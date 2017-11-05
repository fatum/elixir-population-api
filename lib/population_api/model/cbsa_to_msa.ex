alias PopulationApi.Repo

defmodule PopulationApi.Model.CbsaToMsa do
  use Ecto.Schema
  import Ecto.Query

  @lsad "Metropolitan Statistical Area"
  @table __MODULE__

  schema "cbsa_to_msa" do
    field :cbsa, :string
    field :mdiv, :string
    field :lsad, :string
    field :name, :string

    field :popestimate2014, :integer
    field :popestimate2015, :integer
  end

  def lookup_alternate_cbsa(cbsa) do
    record = (from u in @table, where: u.mdiv == ^cbsa, limit: 1) |> Repo.one

    case record do
      nil -> cbsa
      _   -> record.cbsa
    end
  end

  def population(cbsa) do
    real_cbsa = lookup_alternate_cbsa(cbsa)
    (from u in @table, where: u.cbsa == ^real_cbsa and u.lsad == ^@lsad, limit: 1) |> Repo.one
  end

  def table_name do
    __schema__(:source)
  end
end