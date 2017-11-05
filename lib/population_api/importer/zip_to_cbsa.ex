alias PopulationApi.Importer
alias PopulationApi.Model
alias PopulationApi.Repo

defmodule PopulationApi.Importer.ZipToCbsa do
  @delimiter "\r"

  def import!(file) do
    Repo.transaction fn ->
      Repo.delete_all Model.ZipToCbsa.table_name
      Importer.execute(file, @delimiter) |> Stream.each(&import_to_database(&1)) |> Stream.run
    end
  end

  defp import_to_database(chunk) do
    Repo.insert_all Model.ZipToCbsa, chunk |> prepare, on_conflict: :nothing
  end

  defp prepare(chunk) do
    chunk
      |> Enum.reject(&invalid?(&1))
      |> Enum.map(fn el ->
        %{
          zip:  el["ZIP"],
          cbsa: el["CBSA"]
        }
    end)
  end

  defp invalid?(el) do
    el["ZIP"] == nil
  end
end