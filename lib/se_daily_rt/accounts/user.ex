defmodule SEDailyRT.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Accounts.User


  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :auth_id, :string
    has_many :messages, SEDailyRT.Chats.Messages
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :auth_id, :name])
    |> validate_required([:username, :email, :auth_id])
  end

end
