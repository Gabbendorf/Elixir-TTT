defmodule ScoreCalculatorTest do
  use ExUnit.Case

  test "returns 10 for maximising player winning the game" do
    assert ScoreCalculator.score(game_won_by_x(), "X") == 10
  end

  test "returns -10 for maximising player O losing the game " do
    assert ScoreCalculator.score(game_won_by_x(), "O") == -10
  end

  test "returns 0 for draw game" do
    assert ScoreCalculator.score(draw_game(), "X") == 0
  end

  test "returns 10 for game that leads maximising player to win" do
    board = %Board{size: 3, cells: ["X", "O", "X", "O", "X", "O", 7, 8, 9], marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ScoreCalculator.score(game, "X") == 10
  end

  test "returns -10 for game that leads minimising player to win" do
    board = %Board{size: 3, cells: ["O", "X", "O", "X", "O", "X", 7, 8, 9], marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ScoreCalculator.score(game, "X") == -10
  end

  test "returns 0 for game that leads to a draw" do
    board = %Board{size: 3, cells: ["X", "O", "X", "O", "O", "X", "X", 8, 9], marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    assert ScoreCalculator.score(game, "X") == 0
  end

  test "generates next game states for each available position with score" do
    board = %Board{size: 3, cells: ["X", "O", "X", "O", "X", "O", 7, 8, 9], marks: ["X", "O"]}
    current_game_state = %Game{board: board, status: :ongoing, current_player: "O"}

    next_game_states = ScoreCalculator.generate_game_states_with_scores(current_game_state, "X")

    number_of_next_game_states = Enum.count(next_game_states)
    first_game_state = Enum.at(next_game_states, 0)
    second_game_state = Enum.at(next_game_states, 1)
    third_game_state = Enum.at(next_game_states, 2)
    assert number_of_next_game_states == 3
    assert first_game_state.score == 10
    assert second_game_state.score == 10
    assert third_game_state.score == 10
  end

  defp game_won_by_x() do
    winning_board =
      %Board{size: 3, cells: Board.create_cells(3), marks: ["X", "Y"]}
      |> Board.place_mark(1, "X")
      |> Board.place_mark(2, "X")
      |> Board.place_mark(3, "X")

    %Game{board: winning_board, status: :won, current_player: "X"}
  end

  defp draw_game() do
    draw_cells = ["X", "O", "X", "O", "O", "X", "X", "X", "O"]
    draw_board = %Board{size: 3, cells: draw_cells, marks: ["X", "O"]}
    %Game{board: draw_board, status: :draw}
  end
end
