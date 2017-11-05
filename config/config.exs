use Mix.Config

config :logger,
  backends: [:console]

config :population_api, PopulationApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL") || "postgres://app@localhost/population-api-dev"

config :population_api, ecto_repos: [PopulationApi.Repo]

# import_config "#{Mix.env}.exs"
