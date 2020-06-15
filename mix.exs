defmodule Gsi2csgoai.MixProject do
  use Mix.Project

  def project do
    [
      app: :gsi2csgoai,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug, :poison],
      mod: {Gsi2csgoai.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.8"},
      {:plug, "~> 1.10"},
      {:plug_cowboy, "~> 2.3"},
      {:poison, "~> 4.0"},
    ]
  end
end
