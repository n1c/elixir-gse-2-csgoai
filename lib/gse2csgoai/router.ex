defmodule Gsi2csgoai.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Request should be POST")
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    json = Poison.decode!(body)
    # @TODO: send our response to something meaningful
    csgoaiformat = Gsi2csgoai.Transcoder.gsi2csgoai(json)
    IO.inspect(csgoaiformat)

    send_resp(conn, 200, "OK")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
