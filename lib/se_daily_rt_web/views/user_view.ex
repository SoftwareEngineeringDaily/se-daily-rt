defmodule SEDailyRTWeb.UserView do
    use SEDailyRTWeb, :view
  
    def render("user.json", %{user: user}) do
        %{
            auth_id: user.auth_id,
            username: user.username,
            name: user.name
        }
    end
end
  