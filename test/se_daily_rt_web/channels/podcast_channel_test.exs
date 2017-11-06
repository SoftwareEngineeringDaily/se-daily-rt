defmodule SEDailyRTWeb.PodcastChannelTest do
  use SEDailyRTWeb.ChannelCase

  alias SEDailyRTWeb.PodcastChannel

  setup do
    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(PodcastChannel, "podcast:best-podcast-ever", %{"username" => "tester"})
    
    {:ok, socket: socket}
  end

  test "socket contains user information", %{socket: socket} do
    %{assigns: %{podcast_id: podcast_id}} = socket
    assert podcast_id == "best-podcast-ever"
  end

  test "create_chat_message replies with status ok", %{socket: socket} do
    broadcast_from! socket, "create_chat_message", %{"username" => "tester", "text" => "hey there"}
    assert_push "create_chat_message", %{"username" => "tester", "text" => "hey there"}
  end
end
