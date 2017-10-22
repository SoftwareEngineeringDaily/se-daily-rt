defmodule SEDailyRT.Repo.Migrations.RemoveChannelFromMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      remove :channel_id
      add :channel, :string
    end
  end
end
