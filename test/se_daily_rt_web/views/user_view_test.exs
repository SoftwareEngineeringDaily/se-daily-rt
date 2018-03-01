defmodule SEDailyRTWeb.UserViewTest do
  use SEDailyRTWeb.ConnCase, async: true
  
  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render user.json" do
    data = %{user: 
      %{
        auth_id: 123,
        username: "edgar123",
        name: "Edgar PIno"
      }  
    }
    assert render(SEDailyRTWeb.UserView, "user.json", data) ==
      %{auth_id: 123, name: "Edgar PIno", username: "edgar123"}
  end
end
