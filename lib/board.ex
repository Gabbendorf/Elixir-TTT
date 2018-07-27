defmodule Board do

  defstruct [:size, :cells]

  def create_cells(size) do
    Enum.to_list(1..size * size)
  end

  def place_mark(board, position, mark) do
    %{board | cells: List.replace_at(board.cells, position, mark)}
  end

  def rows(cells, size) do
    Enum.chunk_every(cells, size)
  end

  def columns(cells, size) do
    rows(cells, size)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  def diagonal_lines(cells, size) do
    [slice_diagonally(cells, size),
     slice_diagonally(List.flatten(reverse_lines(rows(cells, size))), size)]
  end

  defp reverse_lines(lines) do
    lines
    |> Enum.map(fn(line) -> Enum.reverse(line) end)
  end

  defp slice_diagonally(cells, size) do
    Enum.take_every(cells, size + 1)
  end
end
