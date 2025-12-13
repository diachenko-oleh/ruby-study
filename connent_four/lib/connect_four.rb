class Game
  attr_accessor :grid, :player1, :player2, :player_turn, :game_finished, :last_position

  def initialize(grid = Array.new(6) { Array.new(7) { ' ' } }, player1 = { name: 'player1', symbol: 'x' }, player2 = { name: 'player2', symbol: '0' })
    @grid = grid
    @player1 = player1
    @player2 = player2
    @player_turn = @player1
    @game_finished = false
    @tie = false
    @last_position = []
  end

  def greeting_setup
    puts 'Виберіть новий символ для player1:?'
    @player1[:symbol] = gets.chomp
    until @player1[:symbol].length == 1
      puts 'Довжина має бути 1 знак.'
      @player1[:symbol] = gets.chomp
    end
    puts 'Виберіть новий символ для player2:?'
    @player2[:symbol] = gets.chomp
    until @player2[:symbol].length == 1 && @player2[:symbol] != @player1[:symbol]
      puts 'Довжина має бути 1 знак.'
      @player2[:symbol] = gets.chomp
    end
    puts "Хід #{@player1[:name]}:"
  end

  def print_board
    @grid.each do |row|
      puts ' - - - - - - - - - - - - - -'
      print '| '
      row.each do |column|
        print "#{column} | "
      end
      puts
    end
    puts ' - - - - - - - - - - - - - -'
    puts '  1   2   3   4   5   6   7  '
  end

  def make_selection
    puts 'Оберіть номер стопчика.'
    selection = gets.to_i
    column_full = check_column(selection)
    until ((1..7).include? selection) && (column_full == false)
      puts 'Помилка введення'
      selection = gets.to_i
      column_full = check_column(selection)
    end
    selection
  end

  def check_column(column)
    index = column - 1
    @grid.each do |row|
      if row[index] == ' '
        return false
      end
    end
    true
  end

  def update_board(selection)
    index = selection - 1
    start = -1
    6.times do
      if @grid[start][index] == ' '
        @grid[start][index] = @player_turn[:symbol]
        @last_position = [@grid.length + start, index]
        break
      else
        start -= 1
      end
    end
  end

  def update_player_turn
    if @player_turn == @player1
      @player_turn = @player2
    elsif @player_turn == @player2
      @player_turn = @player1
    end
  end

  def in_bounds?(position)
    if position[0].between?(0, 5)
      if position[1].between?(0, 6)
        true
      end
    end
  end

  def turn_message
    puts "Хід #{@player_turn[:name]}:"
  end

  def end_message
    if @game_finished == true
      if @tie == false
        puts "#{@player_turn[:name]} переміг."
      else
        puts "Нічия"
      end
    end
  end

  def check_draw
    @grid.each do |row|
      if row.include?(' ')
        return false
      end
    end
    @game_finished = true
    @tie = true
  end

  def check_win(current_position, row = 0, column = 0, direction = 'vert', score = 0)
    if score == 4
      @game_finished = true
      return
    end

    case direction
    when 'vert'
      if in_bounds?([row, current_position[1]])
        if @grid[row][current_position[1]] == @player_turn[:symbol]
          score += 1
          row += 1
          check_win(current_position, row, 0, 'vert', score)
        elsif @grid[row][current_position[1]] != @player_turn[:symbol]
          score = 0
          row += 1
          check_win(current_position, row, 0, 'vert', score)
        end
      else
        check_win(@last_position.dup, 0, 0, 'horizont', 0)
      end
    when 'horizont'
      if in_bounds?([current_position[0], column])
        if @grid[current_position[0]][column] == @player_turn[:symbol]
          score += 1
          column += 1
          check_win(current_position, 0, column, 'horizont', score)
        elsif @grid[row][current_position[1]] != @player_turn[:symbol]
          score = 0
          column += 1
          check_win(current_position, 0, column, 'horizont', score)
        end
      else
        check_win(@last_position.dup, 0, 0, 'diag_down', 0)
      end
    when 'diag_down'
      if score.zero?
        row = current_position[0]
        column = current_position[1]
        until row.zero? || column.zero?
          row -= 1
          column -= 1
        end
      end
      if in_bounds?([row, column])
        if @grid[row][column] == @player_turn[:symbol]
          score += 1
          row += 1
          column += 1
          check_win(current_position, row, column, 'diag_down', score)
        else
          check_win(@last_position.dup, 0, 0, 'diag_up', 0)
        end
      end
      check_win(@last_position.dup, 0, 0, 'diag_up', 0)
    when 'diag_up'
      if score.zero?
        row = current_position[0]
        column = current_position[1]
        until row.zero? || column.zero?
          row += 1
          column -= 1
        end
      end
      if in_bounds?([row, column])
        if @grid[row][column] == @player_turn[:symbol]
          score += 1
          row -= 1
          column += 1
          check_win(current_position, row, column, 'diag_up', score)
        end
      end
    end
  end
end