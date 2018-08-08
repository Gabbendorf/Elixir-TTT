defmodule ComputerPlayer do

  def choose_position(game, mark) do
    duplicated_games = ScoreCalculator.generate_game_states_with_scores(game, mark)
    scores = Enum.map(duplicated_games, fn game -> game.score end)
    best_game = Enum.find(duplicated_games, fn game -> game.score == Enum.max(scores) end)
    best_game.game_state.position
  end
end
