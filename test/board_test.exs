defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "creates 9 cells" do
    assert Board.create_cells(3) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  @cells Board.create_cells(3)

  test "creates board with mark placed in given position" do
    board = %Board{size: 3, cells: @cells}

    new_board = Board.place_mark(board, 0, :X)

    assert new_board.cells == [:X, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "creates rows" do
    rows = Board.rows(@cells, 3)

    assert rows == [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  end

  test "creates columns" do
    columns = Board.columns(@cells, 3)

    assert columns == [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end

  test "creates diagonal lines" do
    diagonal_lines = Board.diagonal_lines(@cells, 3)

    assert diagonal_lines == [[1, 5, 9], [3, 5, 7]]
  end

  test "confirms it is winning board" do
    board = %Board{size: 3, cells: @cells}
            |> Board.place_mark(0, :X)
            |> Board.place_mark(1, :X)
            |> Board.place_mark(2, :X)

    assert Board.winning?(board) == true
  end

  test "confirms it is draw board" do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]

    board = %Board{size: 3, cells: draw_cells}

    assert Board.draw?(board) == true
  end
end
