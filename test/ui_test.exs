defmodule UITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  @clear_screen "\e[H\e[2J\n"
  @board "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n"

  test "introduces game" do
    assert capture_io(fn ->
      UI.introduce_ttt
    end) == @clear_screen <> "THIS IS *** TIC-TAC-TOE ***\n"
  end

  test "asks who starts until it gets valid input and returns it formatted" do
    message = capture_io([input: "m\nx\n"], fn ->
      assert UI.prompt_for_starter() == "X"
    end)
    assert message == "Who starts? [enter X or O]\n" <> @clear_screen <> "Sorry, I didn't understand\nWho starts? [enter X or O]\n"
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
    assert message == @board <> "It's X's turn: choose a valid position on the board\n" <> @clear_screen <> "X, you chose an invalid position\n" <> @board <> "It's X's turn: choose a valid position on the board\n" <> @clear_screen <> "X, you chose an invalid position\n" <> @board <> "It's X's turn: choose a valid position on the board\n" <> @clear_screen
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
    end)
    assert answer == "Replay? [enter y or n]\n" <> @clear_screen <> "I'm afraid you typed something wrong\nReplay? [enter y or n]\n"
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
