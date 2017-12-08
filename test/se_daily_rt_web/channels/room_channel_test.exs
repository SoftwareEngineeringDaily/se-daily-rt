defmodule SEDailyRTWeb.RoomChannelTest do
  use SEDailyRTWeb.ChannelCase

  alias SEDailyRTWeb.RoomChannel

  setup do
    user = %{"username" => "tester", "email" => "test@me.com", "_id" => "12323232323", "name" => "The Tester"}
    jwt = user 
          |> Joken.token
          |> Joken.with_signer(Joken.hs256("my_secret"))
          |> Joken.sign 
          |> Joken.get_compact
          
    {:ok, _, socket} =
      
      socket()
      |> subscribe_and_join(RoomChannel, "room:lobby", %{"token" => jwt})
      
    {:ok, socket: socket}
  end
  
  test "create_chat_message replies with status ok", %{socket: socket} do
    broadcast_from! socket, "create_chat_message", %{"username" => "tester", "text" => "hey there"}
    assert_push "create_chat_message", %{"username" => "tester", "text" => "hey there"}
  end
end
