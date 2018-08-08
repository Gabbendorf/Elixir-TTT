defmodule TicTacToeTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "starts new game humanVsHuman where X wins and no replay" do
    winning_message =
      capture_io([input: "x\n1\n2\n5\n3\n9\nn"], fn ->
        assert TicTacToe.run()
      end)

    assert String.contains?(winning_message, "GAME OVER - X won!")
  end

  test "starts new game humanVsHuman that's draw and no replay" do
    draw_message =
      capture_io([input: "x\n1\n2\n3\n4\n6\n5\n7\n9\n8\nn"], fn ->
        assert TicTacToe.run()
      end)

    assert String.contains?(draw_message, "GAME OVER - it's draw!")
  end

  test "starts second game humanVsHuman where O wins after replay" do
    first_game = "x\n1\n2\n5\n3\n9\ny\n"
    second_game = "o\n1\n5\n2\n6\n3\nn"

    winning_message =
      capture_io([input: first_game <> second_game], fn ->
        assert TicTacToe.run()
      end)

    assert String.contains?(winning_message, "GAME OVER - O won!")
  end
end
