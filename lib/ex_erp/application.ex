defmodule ExErp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExErpWeb.Telemetry,
      # Start the Ecto repository
      ExErp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExErp.PubSub},
      # Start Finch
      {Finch, name: ExErp.Finch},
      # Start the Endpoint (http/https)
      ExErpWeb.Endpoint
      # Start a worker by calling: ExErp.Worker.start_link(arg)
      # {ExErp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExErp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExErpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
