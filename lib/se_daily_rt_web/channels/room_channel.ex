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
        # load previous chat messages if any
        %{topic: topic} = socket
        messages = SEDailyRT.Chats.list_channel_messages(topic)
        resp = %{messages: Phoenix.View.render_many(messages, MessageView, "message.json")}

        # trigger the after_join for presense
        send(self(), :after_join)        
        {:ok, resp, assign(socket, :user, %{username: username, id: id})}
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

  def handle_in("create_chat_message", %{"text" => message}, socket) do
    %{assigns: %{user: %{username: username}}, topic: topic} = socket
    message = HtmlSanitizeEx.strip_tags(message)
    # Save to database
    user = create_or_load_user(%{"username" => username})

    case Chats.create_user_message(user, %{body: message, channel: topic}) do 
      {:ok, msg} -> 
        message = msg
        |> Repo.preload(:user)
        |> Phoenix.View.render_one(MessageView, "message.json")
        
        broadcast socket, "new_message", message
        {:reply, :ok, socket}
      {:error, changeset} -> 
        {:reply, changeset, socket}
    end    
  end
  
  # Create or load the user by the username
  defp create_or_load_user(%{"token" => token}) do
    %{"username" => username} = user = decode_token(token)
    case Accounts.get_user_by_username(username) do
      nil -> 
        {:ok, user} = Accounts.create_user(%{"username" => username})
        user
      user -> user
    end
  end
  
  defp decode_token(token) do
    token 
    |> Joken.token
    |> Joken.peek
  end
end
