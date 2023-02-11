defmodule Docs.MixProject do
  use Mix.Project

  def project do
    [
      app: :docs,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Docs.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.0-rc.1", override: true},
      {:phoenix_view ,"~> 2.0"},
      {:phoenix_live_view, "~> 0.18.6"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:toml, "~> 0.6.1"},
      {:json, "~> 1.4"},
      {:earmark, "~> 1.4"},
      {:petal_components, "~> 0.19.0"},

      # {:phoenix_ecto, "~> 4.4"},
      # {:ecto_sql, "~> 3.6"},
      # {:postgrex, ">= 0.0.0"},
      # {:swoosh, "~> 1.3"},
      # {:finch, "~> 0.13"},

      # Development
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.1.8", runtime: Mix.env() == :dev},
      #{:dart_sass, "~> 0.2", runtime: Mix.env() == :dev}

      # Testing
      {:floki, ">= 0.30.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"],
      "assets.deploy": [
        "esbuild default --minify",
        #"sass default --no-source-map --style=compressed",
        "phx.digest"
      ]
    ]
  end
end
