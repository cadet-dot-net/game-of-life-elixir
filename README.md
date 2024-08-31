# GameOfLife

Following this guide:
https://www.freecodecamp.org/news/how-to-build-a-distributed-game-of-life-in-elixir-9152588100cd/

## How to run (with examples)

### Run the first node
```
$ iex --sname node1 -S mix

Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.2.4) - press Ctrl+C to exit (type h() ENTER for help)

16:54:08.554 [info]  Started Elixir.GameOfLife.BoardServer master

iex(node1@Artur)1> GameOfLife.BoardServer.start_game
:game_started

iex(node1@Artur)2> GameOfLife.GamePrinter.start_printing_board
:printing_started
```

### Run a second node in a separate terminal window
We will connect it with the first node.

```
$ iex --sname node2 -S mix

Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.2.4) - press Ctrl+C to exit (type h() ENTER for help)

16:55:17.395 [info]  Started Elixir.GameOfLife.BoardServer master

iex(node2@Artur)1> Node.connect :node1@Artur
true

16:55:17.691 [info]  Started Elixir.GameOfLife.BoardServer slave

iex(node2@Artur)2> Node.list
[:node1@Artur]

iex(node2@Artur)3> Node.self
:node2@Artur

iex(node2@Artur)4> GameOfLife.Patterns.Guns.gosper_glider
|> GameOfLife.BoardServer.add_cells
[
  {24, 8},
  {22, 7}, {24, 7},
  {12, 6}, {13, 6}, {20, 6}, {21, 6}, {34, 6}, {35, 6},
  {11, 5}, {15, 5}, {20, 5}, {21, 5}, {34, 5}, {35, 5},
  {0, 4}, {1, 4}, {10, 4}, {16, 4}, {20, 4}, {21, 4},
  {0, 3}, {1, 3}, {10, 3}, {14, 3}, {16, 3}, {17, 3}, {22, 3}, {24, 3},
  {10, 2}, {16, 2}, {24, 2},
  {11, 1}, {15, 1},
  {12, 0}, {13, 0}
]
```

Both nodes are executing a calculation to determine a new state for living cells.

### Network the nodes (optional)
You can run the game also across different servers in the network like this:

#### start node1
```
$ iex --name node1@192.168.0.101 --cookie "token_for_cluster" -S mix

Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.2.4) - press Ctrl+C to exit (type h() ENTER for help)

iex(node1@192.168.0.101)1>
```

#### start node2 on another server
```
$ iex --name node2@192.168.0.102 --cookie "token_for_cluster" -S mix

Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.2.4) - press Ctrl+C to exit (type h() ENTER for help)

iex(node2@192.168.0.102)1> Node.connect :"node1@192.168.0.101"
true
```