defmodule FoodTruckPals.Repo do
  use Ecto.Repo,
    otp_app: :food_truck_pals,
    adapter: Ecto.Adapters.Postgres
end
