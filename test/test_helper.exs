Mox.defmock(SfgovApiMock, for: Foodtruckpals.Clients.SfgovApiBehaviour)
Application.put_env(:foodtruckpals, :sfgov_api_client, SfgovApiMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Foodtruckpals.Repo, :manual)
