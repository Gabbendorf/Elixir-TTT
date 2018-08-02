defmodule UITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "introduces game" do
    assert capture_io(fn ->
      UI.introduce_ttt
    end) == "THIS IS *** TIC-TAC-TOE ***\n"
  end

  test "asks who starts until it gets valid input" do
    assert capture_io([input: "m\nx\n"], fn ->
      UI.prompt_for_starter()
    end) == "Who starts? [enter X or O]\nSorry, I didn't understand\nWho starts? [enter X or O]\n"
  end

  test "registers and formats starter mark chosen by user" do
    assert capture_io([input: "x\n"], fn ->
      assert UI.prompt_for_starter() == "X"
    end)
  end

  test "prints board" do
    assert capture_io(fn ->
      assert UI.print_board(empty_board_3x3())
    end) == "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n"

  end

  test "asks current player for a position until it gets valid input, and formats it" do
    message = capture_io([input: "m\n10\n1\n"], fn ->
      assert UI.prompt_for_position("X", empty_board_3x3()) == 1
    end)
    assert message == "It's X's turn: choose a valid position on the board\nX, you chose an invalid position\n1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\nIt's X's turn: choose a valid position on the board\nX, you chose an invalid position\n1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\nIt's X's turn: choose a valid position on the board\n"
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

  test "asks to play again until it gets valid answer and returns it formatted" do
    answer = capture_io([input: "h\nY\n"], fn ->
      assert UI.ask_play_again() == "y"
    end) == "Replay? [enter y or n]\nI'm afraid you typed something wrong\nReplay? [enter y or n]\n"
  end

  test "says bye to user" do
    assert capture_io(fn ->
      UI.say_bye()
    end) == "See you soon!\n"
  end

  defp empty_board_3x3() do
    %Board{size: 3, cells: Board.create_cells(3)}
  end
end
