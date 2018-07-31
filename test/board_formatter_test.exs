defmodule BoardFormatterTest do
  use ExUnit.Case

  test "formats board" do
    board = %Board{size: 3, cells: Board.create_cells(3)}

    assert BoardFormatter.format(board) == "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9"
  end
end
