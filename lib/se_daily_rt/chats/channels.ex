defmodule SEDailyRT.Chats.Channels do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias SEDailyRT.Chats.Channels


  schema "channels" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Channels{} = channels, attrs) do
    channels
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
