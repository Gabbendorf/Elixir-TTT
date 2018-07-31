defmodule HumanPlayer do

  def choose_position(player) do
    UI.prompt_for_position(player)
  end
end

