defmodule Foodtruckpals.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodtruckpalsWeb.Telemetry,
      Foodtruckpals.Repo,
      {DNSCluster, query: Application.get_env(:foodtruckpals, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Foodtruckpals.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Foodtruckpals.Finch},
      # Start a worker by calling: Foodtruckpals.Worker.start_link(arg)
      # {Foodtruckpals.Worker, arg},
      # Start to serve requests, typically the last entry
      FoodtruckpalsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foodtruckpals.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodtruckpalsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
