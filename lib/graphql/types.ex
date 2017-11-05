defmodule Graphql.Types do
  use Absinthe.Schema.Notation

  @desc "Estimate"
  object :estimate do
    field :year, :integer
    field :estimate, :integer
  end

  @desc "Population"
  object :population do
    field :zip, :string
    field :cbsa, :string
    field :msa, :string

    field :estimates, list_of(:estimate)
  end
end