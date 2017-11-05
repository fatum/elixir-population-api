alias  PopulationApi.Model

defmodule PopulationApi.Resolver.Population do
  def resolve(""), do: {:error, "Zip not provided"}
  def resolve(zip) do
    zip_record = Model.ZipToCbsa.find_by_zip(zip)

    case zip_record do
      nil -> {:error, "Not found"}
      _   -> lookup_cbsa(zip_record)
    end
  end

  defp lookup_cbsa(zip_record) do
    record = Model.CbsaToMsa.population(zip_record.cbsa)

    case record do
      nil -> {:error, "Not found"}
      _   -> {:ok, build_response(zip_record.zip, record)}
    end
  end

  defp build_response(zip, record) do
    %{
      zip:  zip,
      msa:  record.name,
      cbsa: record.cbsa,
      estimates: [
        %{year: 2014, estimate: record.popestimate2014},
        %{year: 2015, estimate: record.popestimate2015}
      ]
    }
  end
end