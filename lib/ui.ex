defmodule UI do
  defp clear_screen() do
    IO.puts("\e[H\e[2J")
  end

  def introduce_ttt() do
    clear_screen()
    IO.puts("THIS IS *** TIC-TAC-TOE ***")
  end

  def prompt_for_starter() do
    IO.puts("Who starts? [enter X or O]")
    get_starter(String.upcase(String.trim(IO.gets(""))))
  end

  defp get_starter(input) when input in ["X", "O"], do: input

  defp get_starter(_) do
    clear_screen()
    IO.puts("Sorry, I didn't understand")
    prompt_for_starter()
  end

  def print_board(board) do
    IO.puts(BoardFormatter.format(board))
  end

  def prompt_for_position(player, board) do
    print_board(board)
    IO.puts("It's #{player}'s turn: choose a valid position on the board")
    get_position(Integer.parse(IO.gets("")), player, board)
  end

  defp get_position({input_entered, "\n"}, player, board) when is_number(input_entered) do
    if Board.position_available?(board, input_entered) do
      clear_screen()
      input_entered
    else
      get_position(:error, player, board)
    end
  end

  defp get_position(:error, player, board) do
    clear_screen()
    IO.puts("#{player}, you chose an invalid position")
    prompt_for_position(player, board)
  end

  def declare_winner(player) do
    IO.puts("GAME OVER - #{player} won!")
  end

  def declare_draw() do
    IO.puts("GAME OVER - it's draw!")
  end

  def ask_play_again() do
    IO.puts("Replay? [enter y or n]")
    get_replay_answer(String.downcase(String.trim(IO.gets(""))))
  end

  defp get_replay_answer(input) when input in ["y", "n"], do: input

  defp get_replay_answer(_) do
    clear_screen()
    IO.puts("I'm afraid you typed something wrong")
    ask_play_again()
  end

  def say_bye() do
    IO.puts("See you soon!")
  end
end
