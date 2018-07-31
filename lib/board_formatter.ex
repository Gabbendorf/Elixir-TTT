defmodule BoardFormatter do

  def format(board) do
    board.cells
    |> Board.rows(board.size)
    |> Enum.map_join("\n", fn(row) -> Enum.join(row, " | ") end)
  end
end
