alias  PopulationApi.Model

defmodule PopulationApi.Resolver.Population do
  def resolve(zip) do
    record = Model.CbsaToMsa.population(zip)

    case record do
      nil -> {:error, ["Not found"]}
      _   -> {:ok, build_response(zip, record)}
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