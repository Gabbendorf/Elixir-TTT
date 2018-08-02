defmodule MinimaxTest do
  use ExUnit.Case

  test "returns 10 for winning game" do
    assert Minimax.score(game_which(:won)) == 10
  end

  test "returns -10 for losing game" do
    assert Minimax.score(game_which(:lost)) == -10
  end

  test "returns 0 for draw game" do
    assert Minimax.score(draw_game()) == 0
  end

  defp game_which(status) do
    winning_board = %Board{size: 3, cells: Board.create_cells(3)}
                    |> Board.place_mark(1, "X")
                    |> Board.place_mark(2, "X")
                    |> Board.place_mark(3, "X")
    %Game{board: winning_board, status: status}
  end

  defp draw_game() do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]
    draw_board = %Board{size: 3, cells: draw_cells, marks: [:X, :O]}
    %Game{board: draw_board, status: :draw}
  end
end
