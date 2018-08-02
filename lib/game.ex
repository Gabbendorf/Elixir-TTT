defmodule Game do
  defstruct [:board, :status, :current_player]

def update_status(game = %Game{board: board, current_player: current_player}) do
    cond do
      Board.winning?(board) ->
        %{game | status: :won}
      Board.draw?(board) ->
        %{game | status: :draw}
      Board.ongoing?(board) ->
        game
    end
  end

  def switch_player(%Game{board: board, current_player: current_player}) do
    Enum.find(board.marks, fn mark -> mark != current_player end)
  end
end
