defmodule SEDailyRTWeb.RoomChannel do
  @moduledoc """
  Channel for the lobby chat
  
  ## Usage
  
  """
  use SEDailyRTWeb, :channel
  alias SEDailyRTWeb.Presence
  alias SEDailyRTWeb.MessageView
  alias SEDailyRT.Accounts
  alias SEDailyRT.Chats
  alias SEDailyRT.Repo
  

  def join("room:lobby", payload, socket) do
    case Accounts.create_or_load_user(payload) do
      %SEDailyRT.Accounts.User{} = user -> 
        %{topic: topic} = socket
        messages = SEDailyRT.Chats.list_channel_messages(topic)
        resp = %{messages: Phoenix.View.render_many(messages, MessageView, "message.json")}

        # trigger the after_join for presense
        send(self(), :after_join)        
        {:ok, resp, assign(socket, :user, user)}
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
    %{assigns: %{user: user}, topic: topic} = socket
    
    case Chats.create_user_message(user, %{body: body, channel: topic}) do 
      {:ok, message} -> 
        message = message
                  |> Repo.preload(:user)
                  |> Phoenix.View.render_one(MessageView, "message.json")
        
        broadcast socket, "new_message", message
        {:reply, :ok, socket}
      {:error, changeset} -> 
        {:reply, {:error, changeset}, socket}
    end    
  end

end
