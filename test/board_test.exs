defmodule BoardTest do
  use ExUnit.Case

  test "creates 9 cells" do
    assert Board.create_cells(3) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  @cells Board.create_cells(3)
  @board_3x3 %Board{size: 3, cells: @cells, marks: [:X, :O]}

  test "creates board with mark placed in cell corresponding to given position" do
    updated_board = Board.place_mark(@board_3x3, 1, :X)

    assert updated_board.cells == [:X, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "creates rows" do
    rows = Board.rows(@board_3x3)

    assert rows == [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  end

  test "creates columns" do
    columns = Board.columns(@board_3x3)

    assert columns == [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end

  test "creates diagonal lines" do
    diagonal_lines = Board.diagonal_lines(@board_3x3)

    assert diagonal_lines == [[1, 5, 9], [3, 5, 7]]
  end

  test "confirms it is winning board" do
    winning_board = %Board{size: 3, cells: @cells}
            |> Board.place_mark(1, :X)
            |> Board.place_mark(2, :X)
            |> Board.place_mark(3, :X)

    assert Board.winning?(winning_board) == true
  end

  test "figures out the winner" do
    board = %Board{size: 3, cells: @cells}
            |> Board.place_mark(1, :X)
            |> Board.place_mark(2, :X)
            |> Board.place_mark(3, :X)

    assert Board.winner(board) == :X
  end

  test "confirms it is draw board" do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]

    board = %Board{size: 3, cells: draw_cells, marks: [:X, :O]}

    assert Board.draw?(board) == true
  end
end
