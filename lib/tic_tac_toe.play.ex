defmodule Mix.Tasks.Play do
  use Mix.Task

  def run(_) do
    TicTacToe.run()
  end
end
