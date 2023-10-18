defmodule Foodtruckpals.Clients.SfgovApiBehaviour do
  @moduledoc """
  Behaviour for SF gov api client, to support mox implementation for tests.
  """

  @callback get_data() :: {:ok, map()} | {:error, binary()}
end
