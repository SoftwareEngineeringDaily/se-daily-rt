defmodule SEDailyRTWeb.PodcastChannel do
  @moduledoc """
  Channel for individual podcasts
  
  ## Usage
  """
  use SEDailyRTWeb, :channel

  def join("podcast:" <> podcast_id , _payload, socket) do
    {:ok, assign(socket, :podcast_id, podcast_id)}
  end

end
