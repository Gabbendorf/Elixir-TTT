defmodule ScoreCalculator do
  def generate_game_states_with_scores(game, maximising_player) do
    game
    |> duplicate()
    |> Enum.map(& updated_game_state_with_score(&1, maximising_player))
  end

  def score(%Game{status: :won, current_player: maximising_player}, maximising_player), do: 10
  def score(%Game{status: :won}, _), do: -10

  def score(%Game{status: :draw}, _), do: 0

  def score(game = %Game{current_player: current_player}, maximising_player) do
    game
    |> generate_game_states_with_scores(maximising_player)
    |> Enum.map(& &1.score)
    |> minimax(current_player, maximising_player)
  end

  defp updated_game_state_with_score(duplicated_game, maximising_player) do
    %{
      game_state: duplicated_game,
      score: score(duplicated_game.game_with_mark, maximising_player)
    }
  end

  defp minimax(scores, current_player, maximising_player) do
    (current_player == maximising_player) |> minmax(scores)
  end

  defp minmax(true, scores), do: Enum.max(scores)
  defp minmax(false, scores), do: Enum.min(scores)

  defp duplicate(game = %Game{board: board}) do
    board
    |> Board.available_positions()
    |> Enum.map(& updated_board_with_position(game, &1))
    |> update_all_statuses()
  end

  defp updated_board_with_position(game, position) do
    %{
      game_with_mark: %{
        game
        | board: Board.place_mark(game.board, position, Game.switch_player(game)),
        current_player: Game.switch_player(game)
      },
      position: position
    }
  end

  defp update_all_statuses(duplicated_games) do
    duplicated_games
    |> Enum.map(fn game ->
      %{
        game | game_with_mark: Game.update_status(game.game_with_mark)
      }
    end)
  end
end
