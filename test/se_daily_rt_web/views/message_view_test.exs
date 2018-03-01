defmodule SEDailyRTWeb.MessageViewTest do
  use SEDailyRTWeb.ConnCase, async: true
  
  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render message.json" do
    data = %{message: 
      %{
        id: "msg.id",
        body: "msg.body",
        inserted_at: "msg.inserted_at",
        user: %{
          auth_id: 123,
          username: "edgar123",
          name: "Edgar PIno"
        }  
      }  
    }
    assert render(SEDailyRTWeb.MessageView, "message.json", data) ==
    %{body: "msg.body", id: "msg.id", sent_at: "msg.inserted_at", user: %{auth_id: 123, name: "Edgar PIno", username: "edgar123"}}
  end
end
