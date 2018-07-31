defmodule TicTacToeTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "starts new game humanVsHuman and X wins" do
    winning_message = capture_io([input: "x\n1\n2\n5\n3\n9"], fn ->
      assert TicTacToe.run()
    end)
    assert String.contains?(winning_message, "GAME OVER - X won!")
  end

  test "starts new game humanVsHuman and it's draw" do
    draw_message = capture_io([input: "x\n1\n2\n3\n4\n6\n5\n7\n9\n8"], fn ->
      assert TicTacToe.run()
    end)
    assert String.contains?(draw_message, "GAME OVER - it's draw!")
  end
end
