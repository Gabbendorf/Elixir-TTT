defmodule TicTacToe do

  def run() do
    start(new_game())
  end

  defp new_game() do
    UI.introduce_ttt()
    %Game{
      board: %Board{size: 3, cells: Board.create_cells(3), marks: ["X", "O"]},
      current_player: UI.prompt_for_starter()
    }
  end

  defp start(game) do
    UI.print_board(game.board)
    updated_board = Board.place_mark(game.board, HumanPlayer.choose_position(game.current_player), game.current_player)
    if ongoing?(updated_board), do: next_move(game, updated_board), else: result_and_replay(updated_board)
  end

  defp next_move(game, updated_board) do
    %{game |
      board: updated_board,
      current_player: switch_player(game.current_player, game.board.marks)
    }
    |> start
  end

  defp result_and_replay(board) do
    UI.print_board(board)
    cond do
      Board.winning?(board) ->
        UI.declare_winner(Board.winner(board))
      Board.draw?(board) ->
        UI.declare_draw()
    end
    play_again()
  end

  defp play_again() do
    if UI.ask_play_again() == "y", do: start(new_game()), else: UI.say_bye()
  end

  defp ongoing?(board) do
    !Board.winning?(board) && !Board.draw?(board)
  end

  defp switch_player(current_player, marks) do
    Enum.find(marks, fn mark -> mark != current_player end)
  end
end
