defmodule SEDailyRT.JWT.TokenTest do
  use SEDailyRT.DataCase
  alias SEDailyRT.JWT

  describe "jwt" do
    test "that it should decode the JWT" do
      user = %{"username" => "tester", "email" => "test@me.com", "_id" => "12323232323", "name" => "The Tester"}
      jwt = user 
            |> Joken.token
            |> Joken.with_signer(Joken.hs256("my_secret"))
            |> Joken.sign 
            |> Joken.get_compact 
      
      assert JWT.decode(jwt) == user
    end
  end

end
