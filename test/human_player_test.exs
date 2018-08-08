defmodule HumanPlayerTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "returns a position on the board" do
    assert capture_io([input: "1\n"], fn ->
             board = %Board{size: 3, cells: Board.create_cells(3)}

             assert HumanPlayer.choose_position("X", board) == 1
           end)
  end
end
