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

  def prompt_for_position(player, board) do
    IO.puts "It's #{player}'s turn: choose a valid position on the board"
    get_position(Integer.parse(IO.gets ""), player, board)
  end

  defp get_position({input_entered, "\n"}, _, _) when is_number(input_entered), do: input_entered
  defp get_position(:error, player, board) do
    IO.puts "#{player}, you chose an invalid position"
    print_board(board)
    prompt_for_position(player, board)
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

