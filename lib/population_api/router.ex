defmodule PopulationApi.Router do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Poison

  plug :match
  plug :dispatch

  forward "/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: Graphql.Schema,
      default_url: "/graphql"
    ]

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: [schema: Graphql.Schema]

  get "/status" do
    send_resp(conn, 200, "OK")
  end

  get "/favicon.ico" do
    send_resp(conn, 404, "Not found")
  end
end