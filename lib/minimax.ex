defmodule Minimax do

  def score(%Game{status: :won}), do: 10
  def score(%Game{status: :lost}), do: -10
  def score(%Game{status: :draw}), do: 0
end
