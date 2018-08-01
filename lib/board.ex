defmodule Board do

  defstruct [:size, :cells, :marks]

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
    board
    |> rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  def diagonal_lines(board) do
    [slice_diagonally(board.cells, board.size),
     slice_diagonally(reversed_cells_in(rows(board)), board.size)]
  end

  defp reversed_cells_in(lines) do
    List.flatten(reverse_lines(lines))
  end

  defp all_lines(board) do
    rows(board) ++ columns(board) ++ diagonal_lines(board)
  end

  def ongoing?(board) do
    !winning?(board) && !draw?(board)
  end

  def winning?(board) do
    board
    |> all_lines
    |> Enum.any?(&winning_line?/1)
  end

  def winner(board) do
    board
    |> all_lines
    |> Enum.filter(&winning_line?/1)
    |> get_winner_mark
  end

  defp get_winner_mark(winning_line) do
    winning_line
    |> List.flatten
    |> List.first
  end

  defp winning_line?(line) do
    line
    |> Enum.uniq
    |> Enum.count == 1
  end

  defp full?(board) do
    Enum.all?(board.cells, fn(cell) -> Enum.member?(board.marks, cell) end)
  end

  def draw?(board) do
    !winning?(board) && full?(board)
  end

  defp reverse_lines(lines) do
    lines
    |> Enum.map(&Enum.reverse/1)
  end

  defp slice_diagonally(cells, size) do
    Enum.take_every(cells, size + 1)
  end
end
