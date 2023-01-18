defmodule HopTestapp do
  use Application

  def start(_type, _args) do
    IO.puts("Starting test app")

    topologies = [
      hop: [
        strategy: ClusterHop.Strategy.Deployment,
        config: [
          hop_token: System.get_env("HOP_TOKEN")
        ]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: HopTestapp.ClusterSupervisor]]},
      {
        Plug.Cowboy,
        scheme: :http,
        plug: HopTestapp.Http.BaseRouter,
        options: [
          port: 8080
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: HopTestapp.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
