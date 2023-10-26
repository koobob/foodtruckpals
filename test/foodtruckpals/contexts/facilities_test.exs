defmodule Foodtruckpals.Contexts.FacilitiesTest do
  use Foodtruckpals.DataCase

  import Mox

  alias Foodtruckpals.Contexts.Facilities

  describe "get_sfgov_facilities/0" do
    setup :verify_on_exit!

    test "successful api call returns a list of data maps" do
      expect(SfgovApiMock, :get_data, fn ->
        {:ok, "[{\"abc\":\"123\"},{\"def\":\"456\"}]"}
      end)

      {:ok, data} = Facilities.get_sfgov_facilities()
      [obj1, _tail] = data

      assert is_list(data)
      assert is_map(obj1)
    end

    test "json decode error returns appropriate message" do
      expect(SfgovApiMock, :get_data, fn ->
        {:ok, "[{not valid json]"}
      end)

      {:error, message} = Facilities.get_sfgov_facilities()

      assert message == "Error decoding json value"
    end

    test "failed api call passes thru api error" do
      expect(SfgovApiMock, :get_data, fn ->
        {:error, "generic api problem"}
      end)

      {:error, message} = Facilities.get_sfgov_facilities()

      assert message == "generic api problem"
    end
  end

  describe "sync_facilities_data/0" do
    alias Foodtruckpals.Contexts.Facilities.Facility

    test "new rows are  added to cache" do
      before_count =
        Facilities.list_facilities()
        |> Enum.count()

      expect(SfgovApiMock, :get_data, fn ->
        json_data = """
                  [
                    {\"locationid\": \"1\", \"applicant\": \"Name1\"},
                    {\"locationid\": \"2\", \"applicant\": \"Name2\"}
                  ]
        """

        {:ok, json_data}
      end)

      Facilities.sync_sfgov_facilities()

      after_count =
        Facilities.list_facilities()
        |> Enum.count()

      assert after_count == before_count + 2
    end

    test "existing rows are updated in cache" do
      insert(:facility, locationid: 999)
      insert(:facility, locationid: 1000)

      before_count =
        Facilities.list_facilities()
        |> Enum.count()

      expect(SfgovApiMock, :get_data, fn ->
        json_data = """
                  [
                    {\"locationid\": \"1000\", \"applicant\": \"Name1\"},
                    {\"locationid\": \"1001\", \"applicant\": \"Name2\"}
                  ]
        """

        {:ok, json_data}
      end)

      Facilities.sync_sfgov_facilities()

      after_count =
        Facilities.list_facilities()
        |> Enum.count()

      assert after_count == before_count + 1
    end
  end

  describe "facilities" do
    alias Foodtruckpals.Contexts.Facilities.Facility

    @invalid_attrs %{
      status: nil,
      address: nil,
      locationid: nil,
      applicant: nil,
      facility_type: nil,
      food_items: nil,
      latitude: nil,
      longitude: nil,
      schedule_url: nil,
      days_hours: nil
    }

    test "list_facilities/0 returns all facilities" do
      facility = insert(:facility)
      assert Facilities.list_facilities() == [facility]
    end

    test "get_facility!/1 returns the facility with given id" do
      facility = insert(:facility)
      assert Facilities.get_facility!(facility.locationid) == facility
    end

    test "create_facility/1 with valid data creates a facility" do
      valid_attrs = %{
        status: "some status",
        address: "some address",
        locationid: 42,
        applicant: "some applicant",
        facility_type: "some facility_type",
        food_items: "some food_items",
        latitude: 120.5,
        longitude: 120.5,
        schedule_url: "some schedule_url",
        days_hours: "some days_hours"
      }

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
      facility = insert(:facility)

      update_attrs = %{
        status: "some updated status",
        address: "some updated address",
        locationid: 43,
        applicant: "some updated applicant",
        facility_type: "some updated facility_type",
        food_items: "some updated food_items",
        latitude: 456.7,
        longitude: 456.7,
        schedule_url: "some updated schedule_url",
        days_hours: "some updated days_hours"
      }

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
      facility = insert(:facility)
      assert {:error, %Ecto.Changeset{}} = Facilities.update_facility(facility, @invalid_attrs)
      assert facility == Facilities.get_facility!(facility.locationid)
    end

    test "delete_facility/1 deletes the facility" do
      facility = insert(:facility)
      assert {:ok, %Facility{}} = Facilities.delete_facility(facility)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_facility!(facility.locationid) end
    end

    test "change_facility/1 returns a facility changeset" do
      facility = insert(:facility)
      assert %Ecto.Changeset{} = Facilities.change_facility(facility)
    end
  end
end
