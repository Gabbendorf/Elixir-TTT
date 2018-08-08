defmodule ComputerPlayerTest do
  use ExUnit.Case

  test "chooses 7 to win" do
    board = %Board{size: 3,
      cells: ["X", "O", "X",
              "O", "X", "O",
              7,    8,   9],
      marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ComputerPlayer.choose_position(game, "X") == 7
  end

  test "chooses 7 to block opponent" do
    board = %Board{size: 3,
      cells: ["O", "X", "O",
              "X", "O", "X",
              7, 8, 9],
      marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ComputerPlayer.choose_position(game, "X") == 7
  end

  test "blocks fork" do
    board = %Board{size: 3,
      cells: ["O", 2, 3,
              4, "X", 6,
              7, 8, "O"],
      marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ComputerPlayer.choose_position(game, "X") == 2
  end

  test "creates fork" do
    board = %Board{size: 3,
      cells: ["X", 2,  3,
              4,  "O", 6,
              7,   8,  9],
      marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ComputerPlayer.choose_position(game, "X") == 9
  end

end
