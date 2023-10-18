defmodule Foodtruckpals.Clients.SfgovClientTest do
  use ExUnit.Case, async: true

  alias Foodtruckpals.Clients.SfgovClient

  describe "get_data/0" do
    test "returns ok tuple with json data as the resulting value" do
      {:ok, json_data} = SfgovClient.get_data()
      assert is_map(json_data)
    end
  end
end
