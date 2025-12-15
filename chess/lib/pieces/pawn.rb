require_relative 'base_piece'

class Pawn < BasePiece
  def directions
    if at_beginning? && color == :black
      [
        [1, 0],
        [2, 0]
      ]
    elsif at_beginning? && color == :white
      [
        [-1, 0],
        [-2, 0]
      ]
    elsif color == :black && !at_beginning?
      [
        [1, 0]
      ]
    elsif color == :white && !at_beginning?
      [
        [-1, 0]
      ]
    end
  end

  def available_moves
    moves = { av_moves: [], close_friends: [] }
    row, col = location
    directions.each do |(dr, dc)|
      new_loc = [row + dr, col + dc]
      break if out_of_bounds?(new_loc)

      if board[new_loc].nil? && board[one_forward].nil?
        moves[:av_moves] << new_loc
      end
      if color == :black && enemy?(board[[row + 1, col - 1]])
        moves[:av_moves] << [row + 1, col - 1]
      end
      if color == :black && enemy?(board[[row + 1, col + 1]])
        moves[:av_moves] << [row + 1, col + 1]
      end
      if color == :white && enemy?(board[[row - 1, col + 1]])
        moves[:av_moves] << [row - 1, col + 1]
      end
      if color == :white && enemy?(board[[row - 1, col - 1]])
        moves[:av_moves] << [row - 1, col - 1]
      end
      if !board[[row + 1, col - 1]].nil? && color == :black && !enemy?(board[[row + 1, col - 1]])
        moves[:close_friends] << [row + 1, col - 1]
      end
      if !board[[row + 1, col + 1]].nil? && color == :black && !enemy?(board[[row + 1, col + 1]])
        moves[:close_friends] << [row + 1, col + 1]
      end
      if !board[[row - 1, col - 1]].nil? && (color == :white && !enemy?(board[[row - 1, col - 1]]))
        moves[:close_friends] << [row - 1, col - 1]
      end
      if !board[[row - 1, col + 1]].nil? && (color == :white && !enemy?(board[[row - 1, col + 1]]))
        moves[:close_friends] << [row - 1, col + 1]
      end
    end
    moves
  end

  def to_s
    color == :white ? "\u265F" : "\u2659"
  end

  private

  def at_beginning?
    row, _col = location
    row == 1 || row == 6
  end

  def one_forward
    r, c = location
    if color == :black
      [r + 1, c]
    else
      [r - 1, c]
    end
  end
end
