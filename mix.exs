defmodule HopTestapp.MixProject do
  use Mix.Project

  def project do
    [
      app: :libcluster_hop_testapp,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        prod: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HopTestapp, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.13"},
      {:cowboy, "~> 2.9"},
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.4"},
      {:libcluster, "~> 3.3"},
      {:libcluster_hop,
       github: "hiett/libcluster_hop", ref: "6e3a00d2e8e8ea0388135d8c000b999536021909"}
    ]
  end
end
