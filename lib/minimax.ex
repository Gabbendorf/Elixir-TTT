defmodule Minimax do

  def score(%Game{board: board, status: :won, current_player: current_player}) do
    if Board.losing?(board, current_player), do: -10, else: 10
  end
  def score(%Game{status: :draw}), do: 0

  def duplicate(game = %Game{board: board}) do
    Enum.map(Board.available_positions(board), fn position -> %{game |
      board: Board.place_mark(board, position, Game.switch_player(game)),
      current_player: Game.switch_player(game)}
    end)
    |> Enum.map(&Game.update_status/1)
  end
end
