defmodule PopulationApi.Model.ZipToCbsa do
  alias PopulationApi.Repo

  use Ecto.Schema
  import Ecto.Query

  @primary_key false

  schema "zip_to_cbsa" do
    field :zip, :string
    field :cbsa, :string
  end

  def find_by_zip(zip) do
    (from u in __MODULE__, where: u.zip == ^zip) |> Repo.one
  end

  def table_name do
    __schema__(:source)
  end
end