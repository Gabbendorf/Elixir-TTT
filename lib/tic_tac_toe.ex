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
    UI.print_board(game.board)
    play(game)
  end

  defp place_mark(game) do
    %{game |
      board: Board.place_mark(game.board, HumanPlayer.choose_position(game.current_player), game.current_player)}
  end

  defp next_move(game) do
    %{game |
      current_player: switch_player(game.current_player, game.board.marks)
    }
    |> start
  end

  defp result(game) do
    cond do
      game.status == :won ->
        UI.declare_winner(Board.winner(game.board))
      game.status == :draw ->
        UI.declare_draw()
    end
  end

  defp play_again() do
    if UI.ask_play_again() == "y", do: start(new_game()), else: UI.say_bye()
  end

  defp update_status(game) do
    cond do
      Board.winning?(game.board) ->
        %{game | status: :won}
      Board.draw?(game.board) ->
        %{game | status: :draw}
      Board.ongoing?(game.board) ->
        game
    end
  end

  defp play(game = %Game{status: :ongoing}) do
    game
    |> place_mark
    |> update_status
    |> next_move
  end

  defp play(game = %Game{status: status}) when status in [:won, :draw] do
    game
    |> result
    play_again()
  end

  defp switch_player(current_player, marks) do
    Enum.find(marks, fn mark -> mark != current_player end)
  end
end
