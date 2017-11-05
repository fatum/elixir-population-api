alias PopulationApi.Importer

defmodule Mix.Tasks.Import do
  use Mix.Task
  import Mix.Ecto

  require Logger

  @shortdoc "Import zip -> cbsa mapping and msa data"

  def run(_) do
    ensure_started(PopulationApi.Repo, [])

    Importer.ZipToCbsa.import!("zip_to_cbsa.csv")
    Importer.CbsaToMsa.import!("cbsa_to_msa.csv")
  end
end