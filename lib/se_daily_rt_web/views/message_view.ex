defmodule SEDailyRTWeb.MessageView do
    use SEDailyRTWeb, :view
  
    def render("message.json", %{message: msg}) do
        %{
            id: msg.id,
            body: msg.body,
            sent_at: msg.inserted_at,
            user: render_one(msg.user, SEDailyRTWeb.UserView, "user.json")
        }
    end
end
  