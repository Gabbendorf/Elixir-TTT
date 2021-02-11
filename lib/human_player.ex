defmodule HumanPlayer do
  def choose_position(player, board) do
    UI.prompt_for_position(player, board)
  end
end
