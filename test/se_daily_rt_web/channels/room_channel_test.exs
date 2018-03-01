defmodule SEDailyRTWeb.RoomChannelTest do
  use SEDailyRTWeb.ChannelCase

  alias SEDailyRTWeb.RoomChannel
  alias SEDailyRT.Chats
  
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
    ref = push socket, "create_chat_message", %{"body" => "this is a test message"}

    assert_push "new_message", %{body: _body, id: id}
    assert Chats.get_messages!(id)
    assert_reply ref, :ok
  end

  test "create_chat_message with long message body replies with status ok", %{socket: socket} do
    ref = push socket, "create_chat_message", %{"body" => "this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message this is a test message"}

    assert_push "new_message", %{body: _body, id: id}
    assert Chats.get_messages!(id)
    assert_reply ref, :ok
  end
end
