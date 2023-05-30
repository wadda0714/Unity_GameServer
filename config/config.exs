import Config

config :pubsubserver, PubSubServer.Repo,
  database: "pubsubserver_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"
