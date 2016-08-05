use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :seat_saver, SeatSaver.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :seat_saver, SeatSaver.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "test123",
  database: "seat_saver_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox
