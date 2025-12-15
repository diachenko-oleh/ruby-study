require_relative 'base_piece'

class Rook < BasePiece
  include Jumpable

  def directions
    [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0]
    ]
  end

  def to_s
    color == :white ? "\u265C" : "\u2656"
  end
end
