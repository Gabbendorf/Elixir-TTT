defmodule Board do

  defstruct [:size, :cells]

  def create_cells(size) do
    Enum.to_list(1..size * size)
  end

  def place_mark(board, position, mark) do
    %{board | cells: List.replace_at(board.cells, position - 1, mark)}
  end

  def rows(board) do
    Enum.chunk_every(board.cells, board.size)
  end

  def columns(board) do
    rows(board)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  def diagonal_lines(board) do
    [slice_diagonally(board.cells, board.size),
     slice_diagonally(List.flatten(reverse_lines(rows(board))), board.size)]
  end

  defp all_lines(board) do
    rows(board) ++ columns(board) ++ diagonal_lines(board)
  end

  def winning?(board) do
    Enum.any?(all_lines(board), fn(line) -> winning_line?(line) end )
  end

  def winner(board) do
    Enum.filter(all_lines(board), fn(line) -> winning_line?(line) end)
    |> List.flatten
    |> List.first
  end

  defp winning_line?(line) do
    Enum.count(Enum.uniq(line)) == 1
  end

  defp full?(board) do
    Enum.all?(board.cells, fn(cell) -> Enum.member?([:X, :O], cell) end)
  end

  def draw?(board) do
    !winning?(board) && full?(board)
  end

  defp reverse_lines(lines) do
    lines
    |> Enum.map(fn(line) -> Enum.reverse(line) end)
  end

  defp slice_diagonally(cells, size) do
    Enum.take_every(cells, size + 1)
  end
end
