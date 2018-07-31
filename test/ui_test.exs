defmodule UITest do
  use ExUnit.Case
  doctest UI

  import ExUnit.CaptureIO

  test "asks who starts" do
    assert capture_io([input: "x\n"], fn ->
      UI.prompt_for_starter
    end) == "Who starts? [enter X or O]\n"
  end

  test "registers starter chosen by user" do
    assert capture_io([input: "x\n"], fn ->
      assert UI.prompt_for_starter == "x\n"
    end)
  end

  test "asks current player to choose a position" do
    assert capture_io([input: "1\n"], fn ->
      UI.prompt_for_position("X")
    end) == "It's X's turn: choose a valid position on the board\n"
  end

  test "registers position chosen by user" do
    assert capture_io([input: "1\n"], fn ->
      assert UI.prompt_for_position("X") == 1
    end)
  end

  test "declares winner" do
    assert capture_io(fn ->
      UI.declare_winner("X")
    end) == "GAME OVER - X won!\n"
  end

  test "declares draw" do
    assert capture_io(fn ->
      UI.declare_draw()
    end) == "GAME OVER - it's draw!\n"
  end
end
