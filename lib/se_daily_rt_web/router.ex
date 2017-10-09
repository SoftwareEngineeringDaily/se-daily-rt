defmodule SEDailyRTWeb.Router do
  use SEDailyRTWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SEDailyRTWeb do
    pipe_through :api
  end
end
