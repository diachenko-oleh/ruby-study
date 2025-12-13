class Board
  attr_accessor :board
  def initialize(board)
    @board = board
  end

  def new_move(i,j,marker)
    @board[i][j]=marker
  end

  def check_sq(i,j)
    return @board[i][j]
  end

  def print_board
      @board.each do |line|
        p line
      end
  end

  def check_win(marker)
    for i in 0..2
      for i in 0..2
        return true if @board[i].join == marker * 3
      end
    end
    
    for j in 0..2
      line = ""
      for i in 0..2
        line += @board[i][j]
      end
        return true if line == marker * 3
    end

    if [@board[0][0],@board[1][1],@board[2][2]].join == marker * 3
      return true
    elsif [@board[2][0],@board[1][1],@board[0][2]].join == marker * 3
      return true
    end
    false
  end
end