defmodule GameTest do
  use ExUnit.Case

  test "updates status to :won" do
    winning_board = %Board{size: 3, cells: Board.create_cells(3)}
                    |> Board.place_mark(1, :X)
                    |> Board.place_mark(2, :X)
                    |> Board.place_mark(3, :X)
    game = %Game{board: winning_board}

    assert Game.update_status(game).status == :won
  end

  test "updates status to :draw" do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]

    draw_board = %Board{size: 3, cells: draw_cells, marks: [:X, :O]}
    game = %Game{board: draw_board}

    assert Game.update_status(game).status == :draw
  end

  test "does not update :ongoing status" do
    empty_board = %Board{size: 3, cells: Board.create_cells(3), marks: [:X, :O]}
    game = %Game{board: empty_board, status: :ongoing}

    assert Game.update_status(game).status == :ongoing
  end

  test "switches player" do
    empty_board = %Board{size: 3, cells: Board.create_cells(3), marks: [:X, :O]}
    game = %Game{board: empty_board, current_player: :X}

    player = Game.switch_player(game)

    assert player == :O
  end
end
