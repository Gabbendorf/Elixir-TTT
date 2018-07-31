defmodule UI do

  def prompt_for_starter do
    IO.puts "Who starts? [enter X or O]"
    IO.gets ""
  end

  def prompt_for_position(player) do
    IO.puts "It's #{player}'s turn: choose a valid position on the board"
    String.trim(IO.gets "")
    |> String.to_integer
  end

  def declare_winner(player) do
    IO.puts "GAME OVER - #{player} won!"
  end

  def declare_draw() do
    IO.puts "GAME OVER - it's draw!"
  end
end

