defmodule PopulationApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :population_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PopulationApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:absinthe, "~> 1.4.0-rc.3"},
      {:absinthe_plug, "~> 1.4.0-rc.2"},
      {:poison, "~> 3.1"},
      {:cowboy, "~> 1.1"},
      {:ecto, "~> 2.2.6"},
      {:postgrex, "~> 0.13.3"},
      {:csv, "~> 2.0.0"},
      {:exsync, "~> 0.2.1", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
    ]
  end
end
