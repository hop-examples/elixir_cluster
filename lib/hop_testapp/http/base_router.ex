defmodule HopTestapp.Http.BaseRouter do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/" do
    data = %{
      sent_from: "Hop libcluster Deployment Strategy Test App",
      node: node(),
      nodes: Node.list()
    }

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(data))
  end

  match _ do
    data = %{
      error: true,
      message: "path not found"
    }

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(404, Jason.encode!(data))
  end
end
