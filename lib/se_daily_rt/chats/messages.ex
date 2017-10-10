defmodule SEDailyRT.Chats.Messages do
  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Chats.Messages


  schema "messages" do
    field :body, :string
    field :user_id, :id
    field :channel_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Messages{} = messages, attrs) do
    messages
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
