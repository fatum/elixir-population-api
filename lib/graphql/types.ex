defmodule Graphql.Types do
  use Absinthe.Schema.Notation

  @desc "Prediction"
  object :prediction do
    field :year, :integer
    field :prediction, :integer
  end

  @desc "Population"
  object :population do
    field :zip, :string
    field :msa, :string

    field :predictions, list_of(:prediction)
  end
end