defmodule PopulationApi.Repo.Migrations.ZipToCbsa do
  use Ecto.Migration

  def change do
    create table("zip_to_cbsa", primary_key: false) do
      add :zip, :string, size: 6, primary_key: true
      add :cbsa, :string, size: 6
    end
  end
end
