class BasePiece
  attr_reader :color, :board
  attr_accessor :location

  def initialize(board, location, color)
    @location = location
    @color = color
    @board = board
  end

  def enemy?(piece)
    return false if piece.nil?

    piece.color != color
  end

  def out_of_bounds?(position = location)
    row, col = position
    row > 7 || col > 7 || row.negative? || col.negative?
  end

  def protected?
    friends = board.board.flatten.select { |piece| !piece.nil? && !enemy?(piece) }
    friends.collect { |friend| friend.available_moves[:close_friends] }
           .flatten(1)
           .include?(location)
  end
end

module Jumpable
  def available_moves
    moves = { av_moves: [], close_friends: [] }
    directions.each do |(dr, dc)|
      row, col = location
      loop do
        row += dr
        col += dc
        new_loc = [row, col]
        break if out_of_bounds?(new_loc)

        if board[new_loc].nil?
          moves[:av_moves] << new_loc
        elsif !board[new_loc].nil? && !enemy?(board[new_loc])
          moves[:close_friends] << new_loc
          break
        elsif enemy?(board[new_loc])
          moves[:av_moves] << new_loc
          break
        end
      end
    end
    moves
  end
end

module Stepable
  def available_moves
    moves = { av_moves: [], close_friends: [] }
    row, col = location
    directions.each do |(dr, dc)|
      new_loc = [row + dr, col + dc]
      next if out_of_bounds?(new_loc)

      if self.is_a?(King)
        if board[new_loc].nil?
          moves[:av_moves] << new_loc
        elsif enemy?(board[new_loc]) && !board[new_loc].protected?
          moves[:av_moves] << new_loc
        elsif !board[new_loc].nil? && !enemy?(board[new_loc])
          moves[:close_friends] << new_loc
        end
      else
        if board[new_loc].nil? || enemy?(board[new_loc])
          moves[:av_moves] << new_loc
        else
          moves[:close_friends] << new_loc
        end
      end
    end
    moves
  end
end