defmodule MinimaxTest do
  use ExUnit.Case

  test "returns 10 if current player won" do
    assert Minimax.score(game_won_by_x_and_current_player("X")) == 10
  end

  test "returns -10 if current player lost" do
    assert Minimax.score(game_won_by_x_and_current_player("Y")) == -10
  end

  test "returns 0 for draw game" do
    assert Minimax.score(draw_game()) == 0
  end

  test "duplicates game n times where n is number of available positions and mark is switched" do
    board = %Board{size: 3, cells: ["X", "O", "X", "O", "X", "O", 7, 8, 9], marks: ["X", "O"]}
    game = %Game{board: board, status: :ongoing, current_player: "O"}

    duplicated_games = Minimax.duplicate(game)

    number_of_duplicated_games = Enum.count(duplicated_games)
    current_mark = Enum.at(duplicated_games, 1).current_player
    assert number_of_duplicated_games == 3
    assert current_mark == "X"
  end

  defp game_won_by_x_and_current_player(current_player) do
    winning_board = %Board{size: 3, cells: Board.create_cells(3), marks: ["X", "Y"]}
                    |> Board.place_mark(1, "X")
                    |> Board.place_mark(2, "X")
                    |> Board.place_mark(3, "X")
    %Game{board: winning_board, status: :won, current_player: current_player}
  end

  defp draw_game() do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]
    draw_board = %Board{size: 3, cells: draw_cells, marks: [:X, :O]}
    %Game{board: draw_board, status: :draw}
  end
end
