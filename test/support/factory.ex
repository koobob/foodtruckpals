defmodule Foodtruckpals.Factory do
  use ExMachina.Ecto, repo: Foodtruckpals.Repo

  alias Foodtruckpals.Contexts

  def facility_factory() do
    id = sequence(:facilityid, &(&1), start_at: 1000)

    %Contexts.Facilities.Facility{
      address: "#{id} Main Street",
      applicant: "Applicant Name#{id}",
      days_hours: "M-F 9am to 5pm",
      facility_type: sequence(:facility_type, ["truck", "push cart"]),
      food_items: "some food_items",
      latitude: 120.5,
      locationid: id,
      longitude: 120.5,
      schedule_url: "some schedule_url",
      status: sequence(:status, ["Approved", "Requested"])
    }
  end
end
