defmodule SEDailyRT.Repo.Migrations.AddUserColumns do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :auth_id, :string
      add :email, :string
    end

    create unique_index(:users, [:auth_id])
    create unique_index(:users, [:email])
  end
end
