require_relative 'base_piece'

class Knight < BasePiece
  include Stepable

  def directions
    [
      [1, 2],
      [2, 1],
      [-1, 2],
      [-2, 1],
      [1, -2],
      [2, -1],
      [-1, -2],
      [-2, -1]
    ]
  end

  def to_s
    color == :white ? "\u265E" : "\u2658"
  end
end
