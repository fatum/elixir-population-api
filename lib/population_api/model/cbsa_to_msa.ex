defmodule PopulationApi.Model.CbsaToMsa do
  use Ecto.Schema

  @lsad "Metropolitan Statistical Area"

  schema "cbsa_to_msa" do
    field :cbsa, :string
    field :mdiv, :string
    field :lsad, :string

    field :popestimate2014, :integer
    field :popestimate2015, :integer
  end

  def table_name do
    __schema__(:source)
  end
end