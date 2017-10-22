defmodule SEDailyRT.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Accounts.User


  schema "users" do
    field :username, :string
    has_many :messages, SEDailyRT.Chats.Messages
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end

end
