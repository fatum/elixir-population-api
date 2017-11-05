defmodule PopulationApi.Importer do
  @default_delimiter "\n"
  @batch_size 1_000

  def execute(file), do: execute(file, @default_delimiter)

  def execute(file, delimiter) do
    records = File.stream!(file, [:trim_bom]) |> split_lines(delimiter)

    header  = records |> Stream.take(1) |> extract_header()
    records |> Stream.drop(1) |> batch(header)
  end

  defp split_lines(stream, delimiter) do
    stream |> Stream.flat_map(&split_chunk(&1, delimiter))
  end

  defp extract_header(stream) do
    stream
      |> Enum.to_list
      |> Enum.at(0)
      |> String.split(",")
  end

  defp batch(stream, header) do
    stream
      |> Stream.reject(&validate(&1))
      |> Stream.chunk_every(@batch_size)
      |> Stream.map(&process_chunk(&1, header))
  end

  defp validate(element) do
    element == ""
  end

  defp split_chunk(chunk, delimiter) do
    String.split(chunk, delimiter)
  end

  defp process_chunk(rows, headers) do
    list = rows |> CSV.decode() |> Enum.to_list

    # Some rows failed at encoding, skip it...
    records = Enum.reduce list, [], fn(el, acc) ->
      case el do
        {:ok, el} -> [el | acc]
        _ -> acc
      end
    end

    Enum.map records, fn row ->
      Map.new Enum.zip(headers, row)
    end
  end
end