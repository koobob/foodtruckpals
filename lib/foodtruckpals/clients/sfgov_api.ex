defmodule Foodtruckpals.Clients.SfgovApi do
  @moduledoc """
  A client for the SF gov api.
  """

  @behaviour Foodtruckpals.Clients.SfgovApiBehaviour

  @facilities_url "https://data.sfgov.org/resource/rqzj-sfat.json"

  @impl Foodtruckpals.Clients.SfgovApiBehaviour
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
