alias PopulationApi.Importer

defmodule Mix.Tasks.Import do
  use Mix.Task
  import Mix.Ecto

  @shortdoc "Import zip -> cbsa mapping and msa data"

  def run(_) do
    ensure_started(PopulationApi.Repo, [])
    HTTPoison.start

    zip_to_cbsa_url = "https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/zip_to_cbsa.csv"
    cbsa_to_msa_url = "https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/cbsa_to_msa.csv"

    {:ok, cbsa_to_msa} = Download.from(cbsa_to_msa_url)
    {:ok, zip_to_cbsa} = Download.from(zip_to_cbsa_url)

    # TODO take links from args...
    Importer.ZipToCbsa.import!(zip_to_cbsa)
    Importer.CbsaToMsa.import!(cbsa_to_msa)

    File.rm(cbsa_to_msa)
    File.rm(zip_to_cbsa)
  end
end