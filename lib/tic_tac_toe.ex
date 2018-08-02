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
    |> update_status
    |> next_move
  end

  defp play(game) do
    game
    |> result
    play_again()
  end

  defp place_mark(%Game{board: board, current_player: player} = game) do
    %{game |
      board: Board.place_mark(board, HumanPlayer.choose_position(player, board), player)}
  end

  defp next_move(%Game{board: board, current_player: current_player} = game) do
    %{game |
      current_player: switch_player(current_player, board.marks)
    }
    |> start
  end

  defp result(%Game{board: board, status: status}) do
    UI.print_board(board)
    cond do
      status == :won ->
        UI.declare_winner(Board.winner(board))
      status == :draw ->
        UI.declare_draw()
    end
  end

  defp play_again() do
    if UI.ask_play_again() == "y" do
      start(new_game())
    else
      UI.say_bye()
    end
  end

  defp update_status(game = %Game{board: board, current_player: current_player}) do
    cond do
      Board.winning?(board) ->
        %{game | status: :won}
      Board.draw?(board) ->
        %{game | status: :draw}
      Board.ongoing?(board) ->
        game
      Board.losing?(board, current_player) ->
        %{game | status: :lost}
    end
  end

  defp switch_player(current_player, marks) do
    Enum.find(marks, fn mark -> mark != current_player end)
  end
end
