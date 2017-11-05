alias PopulationApi.Repo

defmodule PopulationApi.Model.ZipToCbsa do
  use Ecto.Schema
  import Ecto.Query

  @primary_key false
  @table __MODULE__

  schema "zip_to_cbsa" do
    field :zip, :string
    field :cbsa, :string
  end

  def find_by_zip(zip) do
    (from u in @table, where: u.zip == ^zip, limit: 1) |> Repo.one
  end

  def table_name do
    __schema__(:source)
  end
end