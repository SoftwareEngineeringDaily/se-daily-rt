defmodule SEDailyRT.Repo.Migrations.UpdateMessageSize do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      modify :body, :string, size: 1000
    end
  end
end
