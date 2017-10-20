defmodule SEDailyRTWeb.RoomChannel do
  use SEDailyRTWeb, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("user_join", %{"username" => username}, socket) do
    # Do something here with the username
    broadcast socket, "user_joined", %{"username" => username}
    {:noreply, socket}
  end

  def handle_in("create_chat_message", %{"text" => message, "username" => username}, socket) do
    # Do something here with the username and message
    broadcast socket, "new_message", %{"username" => username, "text" => message}
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    # sends to client using broadcast
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
