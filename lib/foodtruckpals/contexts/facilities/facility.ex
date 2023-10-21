defmodule Foodtruckpals.Contexts.Facilities.Facility do
  use Ecto.Schema
  import Ecto.Changeset

  # Use locationid as the primary key.
  # This data table is a mirror of the sfgov source of truth.
  @primary_key {:locationid, :id, autogenerate: false}

  schema "facilities" do
    field :status, :string
    field :address, :string
    field :applicant, :string
    field :facility_type, :string
    field :food_items, :string
    field :latitude, :float
    field :longitude, :float
    field :schedule_url, :string
    field :days_hours, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(facility, attrs) do
    facility
    |> cast(attrs, [
      :locationid,
      :status,
      :address,
      :applicant,
      :facility_type,
      :food_items,
      :latitude,
      :longitude,
      :schedule_url,
      :days_hours
    ])
    |> validate_required([
      :locationid,
      :applicant
    ])
  end
end
