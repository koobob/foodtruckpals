defmodule FoodTruckPalsWeb.ErrorJSONTest do
  use FoodTruckPalsWeb.ConnCase, async: true

  test "renders 404" do
    assert FoodTruckPalsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert FoodTruckPalsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
