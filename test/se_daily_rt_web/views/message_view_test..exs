defmodule SEDailyRTWeb.MessageViewTest do
  use SEDailyRTWeb.ConnCase, async: true
  
  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render message.json" do
    assert render(SEDailyRTWeb.MessageView, "message.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
