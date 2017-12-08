defmodule SEDailyRT.JWT do
  @moduledoc """
  Helper JWT functions
  """
  
  @doc """
  Decodes a JWT token

  Raises `ArgumentError` if the JWT is bad.
  ## Examples

      iex> decode(jwt)
      %{}

      iex> decode(badJWT)
      ** (ArgumentError)
  """
  def decode(token) do
    token 
    |> Joken.token
    |> Joken.peek
  end
end