defmodule SEDailyRT.Chats.Messages do
  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Chats.Messages


  schema "messages" do
    field :body, :string
    field :user_id, :id
    field :channel, :string
    has_one :user, SEDailyRT.Accounts.User
    
    timestamps()
  end

  @doc false
  def changeset(%Messages{} = messages, attrs) do
    messages
    |> cast(attrs, [:body, :channel])
    |> validate_required([:body, :channel])
  end
end
