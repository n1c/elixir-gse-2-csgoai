defmodule Gsi2csgoai.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Gsi2csgoai.Router, options: [port: 8080])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gsi2csgoai.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
