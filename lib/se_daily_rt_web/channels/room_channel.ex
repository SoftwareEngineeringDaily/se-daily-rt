defmodule SEDailyRTWeb.RoomChannel do
  use SEDailyRTWeb, :channel
  alias SEDailyRTWeb.Presence
  alias SEDailyRTWeb.MessageView
  alias SEDailyRT.Accounts
  alias SEDailyRT.Chats
  alias SEDailyRT.Repo
  

  def join("room:lobby", payload, socket) do
    case create_or_load_user(payload) do
      %{username: username, id: id} -> 
        %{topic: topic} = socket
        %{"token" => token} = payload
        messages = SEDailyRT.Chats.list_channel_messages(topic)
        resp = %{messages: Phoenix.View.render_many(messages, MessageView, "message.json")}

        # trigger the after_join for presense
        send(self(), :after_join)        
        {:ok, resp, assign(socket, :user, %{username: username, id: id, token: token})}
      _ -> 
        {:error, %{reason: "unauthorized"}}
    end
  end

  # Hanle user joins and leaves using Presence
  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.user.username, %{
      online_at: inspect(System.system_time(:seconds))
    })
    {:noreply, socket}
  end

  def handle_in("create_chat_message", %{"body" => body}, socket) do
    %{assigns: %{user: %{id: id}}, topic: topic} = socket
    body = HtmlSanitizeEx.strip_tags(body)
    user = SEDailyRT.Accounts.get_user!(id)

    case Chats.create_user_message(user, %{body: body, channel: topic}) do 
      {:ok, message} -> 
        message = message
                  |> Repo.preload(:user)
                  |> Phoenix.View.render_one(MessageView, "message.json")
        
        broadcast socket, "new_message", message
        {:reply, :ok, socket}
      {:error, changeset} -> 
        {:reply, changeset, socket}
    end    
  end
  
  defp create_or_load_user(%{"token" => token}) do
    %{"username" => username, "email" => email, "_id" => id, "name" => name} = user = decode_token(token)
    case Accounts.get_user_by_account_id(id) do
      nil -> 
        {:ok, user} = Accounts.create_user(%{"username" => username, "email" => email, "auth_id" => id, "name" => name})
        user
      user -> user
    end
  end

  def decode_token(token) do
    token 
    |> Joken.token
    |> Joken.peek
  end
end
