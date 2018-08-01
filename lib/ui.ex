defmodule UI do

  def introduce_ttt() do
    IO.puts "THIS IS *** TIC-TAC-TOE ***"
  end

  def prompt_for_starter() do
    IO.puts "Who starts? [enter X or O]"
    get_starter(String.upcase(String.trim(IO.gets "")))
  end

  defp get_starter(input) when input in ["X", "O"], do: input
  defp get_starter(_) do
    IO.puts "Sorry, I didn't understand"
    prompt_for_starter()
  end

  def print_board(board) do
    IO.puts BoardFormatter.format(board)
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

  def ask_play_again() do
    IO.puts "Replay? [enter y or n]"
    String.trim(IO.gets "")
    |> String.downcase
  end

  def say_bye() do
    IO.puts "See you soon!"
  end
end

