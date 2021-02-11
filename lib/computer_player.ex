defmodule ComputerPlayer do
  def choose_position(game, mark) do
    ScoreCalculator.generate_game_states_with_scores(game, mark)
    |> Enum.max_by(& &1.score)
    |> Map.get(:game_state)
    |> Map.get(:position)
  end
end
