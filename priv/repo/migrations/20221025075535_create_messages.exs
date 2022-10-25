defmodule PhoenixApp.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :display_name, :string
      add :message, :string
      add :deleted_at, :naive_datetime

      timestamps()
    end
  end
end
