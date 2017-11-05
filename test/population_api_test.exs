defmodule PopulationApiTest do
  use ExUnit.Case
  doctest PopulationApi

  test "greets the world" do
    assert PopulationApi.hello() == :world
  end
end
