defmodule Foodtruckpals.Contexts.Facilities do
  @moduledoc """
  The Contexts.Facilities context.
  """

  import Ecto.Query, warn: false
  alias Foodtruckpals.Repo

  alias Foodtruckpals.Contexts.Facilities.Facility

  def get_sfgov_facilities() do
    with {:ok, json} <- api_client().get_data(),
         {:ok, data} <- Jason.decode(json) do
      {:ok, data}
    else
      {:error, %Jason.DecodeError{}} ->
        {:error, "Error decoding json value"}

      {:error, error_message} ->
        {:error, error_message}

      _ ->
        {:error, "Unknown error"}
    end
  end

  def sync_sfgov_facilities() do
    {:ok, sfgov_data} = get_sfgov_facilities()

    Enum.each(sfgov_data, fn entry ->
      case get_facility!(entry.locationid) do
        %Facility{} -> "record found"
        _ -> create_facility(entry)
      end
      create_facility(entry)
    end)
  end

  defp api_client() do
    Application.get_env(:foodtruckpals, :sfgov_api_client, Foodtruckpals.Clients.SfgovApi)
  end

  @doc """
  Returns the list of facilities.

  ## Examples

      iex> list_facilities()
      [%Facility{}, ...]

  """
  def list_facilities do
    Repo.all(Facility)
  end

  @doc """
  Gets a single facility.

  Raises `Ecto.NoResultsError` if the Facility does not exist.

  ## Examples

      iex> get_facility!(123)
      %Facility{}

      iex> get_facility!(456)
      ** (Ecto.NoResultsError)

  """
  def get_facility!(id), do: Repo.get!(Facility, id)

  @doc """
  Creates a facility.

  ## Examples

      iex> create_facility(%{field: value})
      {:ok, %Facility{}}

      iex> create_facility(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_facility(attrs \\ %{}) do
    %Facility{}
    |> Facility.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a facility.

  ## Examples

      iex> update_facility(facility, %{field: new_value})
      {:ok, %Facility{}}

      iex> update_facility(facility, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_facility(%Facility{} = facility, attrs) do
    facility
    |> Facility.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a facility.

  ## Examples

      iex> delete_facility(facility)
      {:ok, %Facility{}}

      iex> delete_facility(facility)
      {:error, %Ecto.Changeset{}}

  """
  def delete_facility(%Facility{} = facility) do
    Repo.delete(facility)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking facility changes.

  ## Examples

      iex> change_facility(facility)
      %Ecto.Changeset{data: %Facility{}}

  """
  def change_facility(%Facility{} = facility, attrs \\ %{}) do
    Facility.changeset(facility, attrs)
  end
end
