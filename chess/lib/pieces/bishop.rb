require_relative 'base_piece'

class Bishop < BasePiece
  include Jumpable

  def directions
    [
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, -1]
    ]
  end

  def to_s
    color == :white ? "\u265D" : "\u2657"
  end
end
