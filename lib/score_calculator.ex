defmodule ScoreCalculator do
  def generate_game_states_with_scores(game, maximising_player) do
    Enum.map(duplicate(game), fn duplicated_game ->
      %{
        game_state: duplicated_game,
        score: score(duplicated_game.game_with_mark, maximising_player)
      }
    end)
  end

  def score(%Game{status: :won, current_player: current_player}, maximising_player) do
    if current_player == maximising_player, do: 10, else: -10
  end

  def score(%Game{status: :draw}, _), do: 0

  def score(game = %Game{current_player: current_player}, maximising_player) do
    Enum.map(generate_game_states_with_scores(game, maximising_player), fn game -> game.score end)
    |> minimax(current_player, maximising_player)
  end

  defp minimax(scores, current_player, maximising_player)
       when current_player == maximising_player do
    Enum.max(scores)
  end

  defp minimax(scores, current_player, maximising_player)
       when current_player != maximising_player do
    Enum.min(scores)
  end

  defp duplicate(game = %Game{board: board}) do
    Enum.map(Board.available_positions(board), fn position ->
      %{
        game_with_mark: %{
          game
          | board: Board.place_mark(board, position, Game.switch_player(game)),
            current_player: Game.switch_player(game)
        },
        position: position
      }
    end)
    |> update_all_statuses
  end

  defp update_all_statuses(duplicated_games) do
    Enum.map(duplicated_games, fn duplicated_game ->
      %{
        duplicated_game
        | game_with_mark: Game.update_status(duplicated_game.game_with_mark)
      }
    end)
  end
end
