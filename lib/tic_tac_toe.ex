defmodule TicTacToe do
  def run() do
    start(new_game())
  end

  defp new_game() do
    UI.introduce_ttt()

    %Game{
      board: %Board{size: 3, cells: Board.create_cells(3), marks: ["X", "O"]},
      status: :ongoing,
      current_player: UI.prompt_for_starter()
    }
  end

  defp start(game) do
    play(game)
  end

  defp play(game = %Game{status: :ongoing}) do
    game
    |> place_mark
    |> Game.update_status()
    |> next_move
  end

  defp play(game = %Game{board: board}) do
    game
    |> Game.result()

    UI.print_board(board)
    play_again(UI.ask_play_again())
  end

  defp place_mark(%Game{board: board, current_player: player} = game) do
    %{game | board: Board.place_mark(board, HumanPlayer.choose_position(player, board), player)}
  end

  defp next_move(game) do
    %{game | current_player: Game.switch_player(game)}
    |> start
  end

  defp play_again("y"), do: start(new_game())
  defp play_again("n"), do: UI.say_bye()
end
