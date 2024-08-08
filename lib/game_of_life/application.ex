defmodule GameOfLife.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    init_alive_cells = []
    # Define workers and child supervisors to be supervised
    children = [
      # worker(GameOfLife.Worker, [arg1, arg2, arg3])
      supervisor(Task.Supervisor, [[name: GameOfLife.TaskSupervisor]]),
      worker(GameOfLife.BoardServer, [init_alive_cells])
      # We will uncomment this line later
      # worker(GameOfLife.GamePrinter, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameOfLife.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
