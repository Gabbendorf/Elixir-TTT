defmodule GameTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "updates status to :won" do
    assert Game.update_status(winning_game()).status == :won
  end

  test "updates status to :draw" do
    assert Game.update_status(draw_game()).status == :draw
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

  test "declares winner for :won status" do
    assert capture_io(fn ->
      Game.result(winning_game())
    end) == "GAME OVER - X won!\n"
  end

  test "declares draw for :drawstatus" do
    assert capture_io(fn ->
      Game.result(draw_game())
    end) == "GAME OVER - it's draw!\n"
  end

  defp winning_game() do
    winning_board = %Board{size: 3, cells: Board.create_cells(3)}
                    |> Board.place_mark(1, :X)
                    |> Board.place_mark(2, :X)
                    |> Board.place_mark(3, :X)
    %Game{board: winning_board, status: :won}
  end

  defp draw_game() do
    draw_cells = [:X, :O, :X,
                  :O, :O, :X,
                  :X, :X, :O]

    draw_board = %Board{size: 3, cells: draw_cells, marks: [:X, :O]}
    %Game{board: draw_board, status: :draw}
  end
end
