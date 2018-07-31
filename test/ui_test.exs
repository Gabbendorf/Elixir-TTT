defmodule UITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "introduces game" do
    assert capture_io(fn ->
      UI.introduce_ttt
    end) == "THIS IS *** TIC-TAC-TOE ***\n"
  end

  test "asks who starts" do
    assert capture_io([input: "x\n"], fn ->
      UI.prompt_for_starter
    end) == "Who starts? [enter X or O]\n"
  end

  test "registers and formats starter mark chosen by user" do
    assert capture_io([input: "x\n"], fn ->
      assert UI.prompt_for_starter == "X"
    end)
  end

  test "prints board" do
    assert capture_io(fn ->
      board = %Board{size: 3, cells: Board.create_cells(3)}

      assert UI.print_board(board)
    end) == "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n"

  end

  test "asks current player to choose a position" do
    assert capture_io([input: "1\n"], fn ->
      UI.prompt_for_position("X")
    end) == "It's X's turn: choose a valid position on the board\n"
  end

  test "registers and formats position chosen by user" do
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

  test "asks to play again" do
    assert capture_io([input: "y\n"], fn ->
      UI.ask_play_again()
    end) == "Replay? [enter y or n]\n"
  end

  test "registers and formats answer from user" do
    assert capture_io([input: "Y\n"], fn ->
      assert UI.ask_play_again() == "y"
    end)
  end

  test "says bye to user" do
    assert capture_io(fn ->
      UI.say_bye()
    end) == "See you soon!\n"
  end
end
