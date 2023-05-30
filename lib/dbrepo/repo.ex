defmodule PubSubServer.Repo do
  use Ecto.Repo,
    otp_app: :pubsubserver,
    adapter: Ecto.Adapters.Postgres
end
