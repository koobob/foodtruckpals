defmodule Foodtruckpals.Clients.SfgovClient do
  @moduledoc """
  A client for the SF gov api.
  """

  @facilities_url "https://data.sfgov.org/resource/rqzj-sfat.json"

  @doc """
  Grabs data for all facilities as a Map.
  """
  def get_data() do
    response =
      Finch.build(:get, @facilities_url)
      |> Finch.request(Foodtruckpals.Finch)

    case response do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        {:ok, body}
      {:ok, %Finch.Response{status: status}} ->
        {:error, "Request returned error with http status: #{status}"}
      _ ->
        {:error, "Unknown error returned"}
    end
  end
end
