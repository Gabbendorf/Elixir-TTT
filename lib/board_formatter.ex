defmodule BoardFormatter do
  def format(board) do
    board
    |> Board.rows()
    |> Enum.map_join("\n", fn row -> Enum.join(row, " | ") end)
  end
end
