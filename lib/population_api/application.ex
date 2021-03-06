defmodule PopulationApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: PopulationApi.Worker.start_link(arg)
      # {PopulationApi.Worker, arg},
      Plug.Adapters.Cowboy.child_spec(:http, PopulationApi.Router, [], [port: get_port()]),
      supervisor(PopulationApi.Repo, [])
    ]

    start_sync!()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PopulationApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp start_sync! do
    case Code.ensure_loaded(ExSync) do
       {:module, ExSync = mod} ->
         mod.start()
       {:error, :nofile} ->
         :ok
     end
  end

  defp get_port do
    case System.get_env("PORT") do
      ""    -> 4001
      nil   -> 4001
      port  -> String.to_integer(port)
    end
  end
end
