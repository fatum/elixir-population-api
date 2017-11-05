alias PopulationApi.Importer
alias PopulationApi.Model
alias PopulationApi.Repo

defmodule PopulationApi.Importer.CbsaToMsa do
  @delimiter "\n"

  def import!(file) do
    Repo.transaction fn ->
      Repo.delete_all Model.CbsaToMsa.table_name
      Importer.execute(file, @delimiter) |> Stream.each(&import_to_database(&1)) |> Stream.run
    end
  end

  defp import_to_database(chunk) do
    Repo.insert_all Model.CbsaToMsa, chunk |> prepare, on_conflict: :nothing
  end

  defp prepare(chunk) do
    Enum.map chunk, fn el ->
      %{
        cbsa: el["CBSA"],
        mdiv: el["MDIV"],
        lsad: el["LSAD"],
        popestimate2014: el["POPESTIMATE2014"] |> cast,
        popestimate2015: el["POPESTIMATE2015"] |> cast
      }
    end
  end

  defp cast(""), do: nil
  defp cast(string), do: String.to_integer(string)
end