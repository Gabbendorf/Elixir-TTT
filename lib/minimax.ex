defmodule Minimax do

  def score(%Game{board: board, status: :won, current_player: current_player}) do
    if Board.losing?(board, current_player), do: -10, else: 10
  end
  def score(%Game{status: :draw}), do: 0

  def duplicate(game = %Game{board: board}) do
    Enum.map(Board.available_positions(board), fn position ->
      %{
        game_with_move: %{ game |
          board: Board.place_mark(board, position, Game.switch_player(game)),
          current_player: Game.switch_player(game)
        },
        position: position
      }
    end)
    |> update_all_statuses
  end

  defp update_all_statuses(duplicated_games) do
    Enum.map(duplicated_games, fn duplicated_game -> %{
      duplicated_game |
      game_with_move: Game.update_status(duplicated_game.game_with_move)
    }
    end)
  end
end
