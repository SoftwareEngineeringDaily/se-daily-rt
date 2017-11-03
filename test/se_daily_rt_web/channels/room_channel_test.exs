defmodule SEDailyRTWeb.RoomChannelTest do
  use SEDailyRTWeb.ChannelCase

  alias SEDailyRTWeb.RoomChannel

  setup do
    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(RoomChannel, "room:lobby", %{"username" => "tester"})
      
    {:ok, socket: socket}
  end
  
  test "create_chat_message replies with status ok", %{socket: socket} do
    broadcast_from! socket, "create_chat_message", %{"username" => "tester", "text" => "hey there"}
    assert_push "create_chat_message", %{"username" => "tester", "text" => "hey there"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
