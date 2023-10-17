defmodule Foodtruckpals.Contexts.FacilitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Foodtruckpals.Contexts.Facilities` context.
  """

  @doc """
  Generate a facility.
  """
  def facility_fixture(attrs \\ %{}) do
    {:ok, facility} =
      attrs
      |> Enum.into(%{
        address: "some address",
        applicant: "some applicant",
        days_hours: "some days_hours",
        facility_type: "some facility_type",
        food_items: "some food_items",
        latitude: 120.5,
        locationid: 42,
        longitude: 120.5,
        schedule_url: "some schedule_url",
        status: "some status"
      })
      |> Foodtruckpals.Contexts.Facilities.create_facility()

    facility
  end
end
