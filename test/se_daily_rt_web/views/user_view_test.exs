defmodule SEDailyRTWeb.UserViewTest do
  use SEDailyRTWeb.ConnCase, async: true
  
  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render user.json" do
    assert render(SEDailyRTWeb.UserView, "user.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
