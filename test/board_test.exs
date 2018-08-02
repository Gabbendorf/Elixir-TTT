defmodule BoardTest do
  use ExUnit.Case

  test "creates 9 cells" do
    assert Board.create_cells(3) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "creates board with mark placed in cell corresponding to given position" do
    updated_board = Board.place_mark(empty_3x3_board(), 1, :X)

    assert updated_board.cells == [:X, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "creates rows" do
    rows = Board.rows(empty_3x3_board())

    assert rows == [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  end

  test "confirms it is ongoing board" do
    assert Board.ongoing?(empty_3x3_board()) == true
  end

  test "confirms winning board is not ongoing board" do
    assert Board.ongoing?(x_winning_board()) == false
  end

  test "confirms draw board is not ongoing board" do
    assert Board.ongoing?(draw_board()) == false
  end

  test "confirms it is winning board" do
    assert Board.winning?(x_winning_board()) == true
  end

  test "confirms it is losing board if winner is different from passed player" do
    assert Board.losing?(x_winning_board(), :Y) == true
  end

  test "figures out the winner" do
    assert Board.winner(x_winning_board()) == :X
  end

  test "confirms it is draw board" do
    assert Board.draw?(draw_board()) == true
  end

  test "confirms a position is available" do
    assert Board.position_available?(empty_3x3_board(), 1)
  end

  test "confirms a position is out of range" do
    assert Board.position_available?(empty_3x3_board(), 10) == false
  end

  test "confirms a position is already occupied" do
    board = %Board{size: 3, cells: Board.create_cells(3)}
            |> Board.place_mark(1, :X)

    assert Board.position_available?(board, 1) == false
  end

  defp draw_board() do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]

    %Board{size: 3, cells: draw_cells, marks: [:X, :O]}
  end

  defp empty_3x3_board() do
    %Board{size: 3, cells: Board.create_cells(3), marks: [:X, :O]}
  end

  defp x_winning_board() do
    %Board{size: 3, cells: Board.create_cells(3)}
    |> Board.place_mark(1, :X)
    |> Board.place_mark(2, :X)
    |> Board.place_mark(3, :X)
  end
end
