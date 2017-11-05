defmodule Graphql.Schema do
  use Absinthe.Schema

  import_types Graphql.Types

  query do
    field :get_population, :population do
      arg :zip, non_null(:string)

      resolve fn %{zip: zip}, _ ->
        {:ok, %{}}
      end
    end
  end
end
