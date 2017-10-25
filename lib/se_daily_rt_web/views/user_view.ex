defmodule SEDailyRTWeb.UserView do
    use SEDailyRTWeb, :view
  
    def render("user.json", %{user: user}) do
        %{
            id: user.id,
            username: user.username
        }
    end
end
  