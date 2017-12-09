defmodule SEDailyRT.Chats.Messages do
  @moduledoc false
  
  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Chats.Messages


  schema "messages" do
    field :body, :string
    field :channel, :string
    belongs_to :user, SEDailyRT.Accounts.User
    
    timestamps()
  end

  @doc false
  def changeset(%Messages{} = messages, attrs) do
    messages
    |> cast(attrs, [:body, :channel])
    |> validate_required([:body, :channel])
  end
end
