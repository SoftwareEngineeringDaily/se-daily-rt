defmodule SEDailyRT.Token do
  def decode_token(token) do
    token 
    |> Joken.token
    |> Joken.peek
  end
end