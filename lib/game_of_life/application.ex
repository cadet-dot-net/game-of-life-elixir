defmodule GameOfLife.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    init_alive_cells = []

    children = [
      %{
        id: GameOfLife.TaskSupervisor,
        start: {Task.Supervisor, :start_link, []},
        type: :supervisor
      },
      %{
        id: GameOfLife.BoardServer,
        start: {GameOfLife.BoardServer, :start_link, [init_alive_cells]},
        type: :worker
      },
      %{
        id: GameOfLife.GamePrinter,
        start: {GameOfLife.GamePrinter, :start_link, []},
        type: :worker
      }
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameOfLife.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
