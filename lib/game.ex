defmodule Game do
  defstruct [:board, :status, :current_player]

def update_status(game = %Game{board: board}) do
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

  def result(%Game{board: board, status: :won}) do
    UI.declare_winner(Board.winner(board))
  end
  def result(%Game{status: :draw}) do
    UI.declare_draw()
  end
end
