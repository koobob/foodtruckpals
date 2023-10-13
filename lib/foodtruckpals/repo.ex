defmodule Foodtruckpals.Repo do
  use Ecto.Repo,
    otp_app: :foodtruckpals,
    adapter: Ecto.Adapters.Postgres
end
