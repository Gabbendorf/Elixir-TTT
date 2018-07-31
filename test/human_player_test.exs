defmodule HumanPlayerTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "returns a position on the board" do
    assert capture_io([input: "1\n"], fn ->
      assert HumanPlayer.choose_position("X") == 1
    end)
  end
end
