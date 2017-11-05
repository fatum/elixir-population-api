defmodule PopulationApi.Repo.Migrations.CreateCbsaToMsa do
  use Ecto.Migration

  def change do
    create table("cbsa_to_msa") do
      add :cbsa, :string, size: 6
      add :mdiv, :string
      add :lsad, :string
      add :name, :string

      add :popestimate2014, :integer
      add :popestimate2015, :integer
    end

    # Index for alternate CBSA lookup
    create index("cbsa_to_msa", [:mdiv])
    create index("cbsa_to_msa", [:cbsa, :lsad])
  end
end
