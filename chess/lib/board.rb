require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](location)
    r, c = location
    board[r][c]
  end

  def []=(location, piece)
    r, c = location
    board[r][c] = piece
  end

  def checkmate?
    return false unless in_check?

    first_king = kings.first
    second_king = kings.last

    first_enem_moves = board.flatten.select { |piece| first_king.enemy?(piece) }
                            .collect { |enemy| enemy.available_moves[:av_moves] }
    second_enem_moves = board.flatten.select { |piece| second_king.enemy?(piece) }
                             .collect { |enemy| enemy.available_moves[:av_moves] }

    first_king.available_moves[:av_moves].all? { |m| first_enem_moves.flatten(1).include?(m) } ||
      second_king.available_moves[:av_moves].all? { |m| second_enem_moves.flatten(1).include?(m) }
  end

  def in_check?
    pieces.each do |piece|
      kings.each do |king|
        return true if piece.available_moves[:av_moves].include?(king.location)
      end
    end
    false
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise 'Invalid Move' unless piece.available_moves[:av_moves].include?(end_pos)
    
    self[end_pos] = piece
    piece.location = end_pos
    self[start_pos] = nil
  end

  def render
    numbers = ('1'..'8').to_a.reverse!
    letters = ('a'..'h').to_a

    numbers.each_with_index do |num, r|
      puts ''
      puts '  -------------------------------'
      print "#{num} | "
      letters.each_index do |c|
        piece = board[r][c]
        print ' ' if piece.nil?
        print "#{piece}|  "
      end
    end
    puts ''
    puts '  -------------------------------'
    letters.each { |l| print "   #{l}" }
    puts ''
  end

  def set_board
    8.times do |i|
      board[1][i] = Pawn.new(self, [1, i], :black)
      board[6][i] = Pawn.new(self, [6, i], :white)
    end
    board[0][0] = Rook.new(self, [0, 0], :black)
    board[0][7] = Rook.new(self, [0, 7], :black)
    board[7][0] = Rook.new(self, [7, 0], :white)
    board[7][7] = Rook.new(self, [7, 7], :white)

    board[0][1] = Knight.new(self, [0, 1], :black)
    board[0][6] = Knight.new(self, [0, 6], :black)
    board[7][1] = Knight.new(self, [7, 1], :white)
    board[7][6] = Knight.new(self, [7, 6], :white)

    board[0][2] = Bishop.new(self, [0, 2], :black)
    board[0][5] = Bishop.new(self, [0, 5], :black)
    board[7][2] = Bishop.new(self, [7, 2], :white)
    board[7][5] = Bishop.new(self, [7, 5], :white)

    board[0][4] = King.new(self, [0, 4], :black)
    board[7][4] = King.new(self, [7, 4], :white)

    board[0][3] = Queen.new(self, [0, 3], :black)
    board[7][3] = Queen.new(self, [7, 3], :white)
  end

  private

  def kings
    board.flatten.select { |piece| piece.is_a?(King) }
  end

  def pieces
    board.flatten.select { |piece| !piece.is_a?(King) && !piece.nil? }
  end
end