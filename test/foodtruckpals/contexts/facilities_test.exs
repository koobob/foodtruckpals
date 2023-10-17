defmodule Foodtruckpals.Contexts.FacilitiesTest do
  use Foodtruckpals.DataCase

  alias Foodtruckpals.Contexts.Facilities

  describe "facilities" do
    alias Foodtruckpals.Contexts.Facilities.Facility

    import Foodtruckpals.Contexts.FacilitiesFixtures

    @invalid_attrs %{status: nil, address: nil, locationid: nil, applicant: nil, facility_type: nil, food_items: nil, latitude: nil, longitude: nil, schedule_url: nil, days_hours: nil}

    test "list_facilities/0 returns all facilities" do
      facility = facility_fixture()
      assert Facilities.list_facilities() == [facility]
    end

    test "get_facility!/1 returns the facility with given id" do
      facility = facility_fixture()
      assert Facilities.get_facility!(facility.id) == facility
    end

    test "create_facility/1 with valid data creates a facility" do
      valid_attrs = %{status: "some status", address: "some address", locationid: 42, applicant: "some applicant", facility_type: "some facility_type", food_items: "some food_items", latitude: 120.5, longitude: 120.5, schedule_url: "some schedule_url", days_hours: "some days_hours"}

      assert {:ok, %Facility{} = facility} = Facilities.create_facility(valid_attrs)
      assert facility.status == "some status"
      assert facility.address == "some address"
      assert facility.locationid == 42
      assert facility.applicant == "some applicant"
      assert facility.facility_type == "some facility_type"
      assert facility.food_items == "some food_items"
      assert facility.latitude == 120.5
      assert facility.longitude == 120.5
      assert facility.schedule_url == "some schedule_url"
      assert facility.days_hours == "some days_hours"
    end

    test "create_facility/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facilities.create_facility(@invalid_attrs)
    end

    test "update_facility/2 with valid data updates the facility" do
      facility = facility_fixture()
      update_attrs = %{status: "some updated status", address: "some updated address", locationid: 43, applicant: "some updated applicant", facility_type: "some updated facility_type", food_items: "some updated food_items", latitude: 456.7, longitude: 456.7, schedule_url: "some updated schedule_url", days_hours: "some updated days_hours"}

      assert {:ok, %Facility{} = facility} = Facilities.update_facility(facility, update_attrs)
      assert facility.status == "some updated status"
      assert facility.address == "some updated address"
      assert facility.locationid == 43
      assert facility.applicant == "some updated applicant"
      assert facility.facility_type == "some updated facility_type"
      assert facility.food_items == "some updated food_items"
      assert facility.latitude == 456.7
      assert facility.longitude == 456.7
      assert facility.schedule_url == "some updated schedule_url"
      assert facility.days_hours == "some updated days_hours"
    end

    test "update_facility/2 with invalid data returns error changeset" do
      facility = facility_fixture()
      assert {:error, %Ecto.Changeset{}} = Facilities.update_facility(facility, @invalid_attrs)
      assert facility == Facilities.get_facility!(facility.id)
    end

    test "delete_facility/1 deletes the facility" do
      facility = facility_fixture()
      assert {:ok, %Facility{}} = Facilities.delete_facility(facility)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_facility!(facility.id) end
    end

    test "change_facility/1 returns a facility changeset" do
      facility = facility_fixture()
      assert %Ecto.Changeset{} = Facilities.change_facility(facility)
    end
  end
end
