defmodule Foodtruckpals.Repo.Migrations.CreateFacilities do
  use Ecto.Migration

  def change do
    create table(:facilities, primary_key: [name: :locationid, type: :integer]) do
      add :applicant, :string
      add :facility_type, :string
      add :address, :string
      add :food_items, :string
      add :latitude, :float
      add :longitude, :float
      add :schedule_url, :string
      add :days_hours, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
