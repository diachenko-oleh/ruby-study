require_relative 'board'
require_relative 'player'

class Game
  def initialize(player1_name = "player1", player2_name = "player2")
    board_array = Array.new(3) { Array.new(3, "-") }
    @board = Board.new(board_array)

    @player1 = Player.new(player1_name)
    @player2 = Player.new(player2_name)

    @empty_sq = 9
    @zero_turn = true
    @is_result = false
  end

  def play
    while @empty_sq > 0
      current_player, marker = current_turn

      make_move(marker)

      if @board.check_win(marker)
        end_game_with_win(current_player)
        return
      end

      @board.print_board
      @empty_sq -= 1
      @zero_turn = !@zero_turn
    end

    end_game_with_draw
  end

  private

  def current_turn
    if @zero_turn
      [@player1, "0"]
    else
      [@player2, "X"]
    end
  end

  def make_move(marker)
    loop do
      puts "Введіть координати для вашого '#{marker}' через пробіл. Значення має бути в діапазоні [0,2]"
      coords = gets.chomp.split
      i = coords[0].to_i
      j = coords[1].to_i

      if valid_coordinates?(i, j)
        if @board.check_sq(i, j) == "-"
          @board.new_move(i, j, marker)
          break
        else
          puts "Місце зайняте!"
        end
      else
        puts "Непідходящі значення!"
      end
    end
  end

  def valid_coordinates?(i, j)
    (0..2).cover?(i) && (0..2).cover?(j)
  end

  def end_game_with_win(player)
    @board.print_board
    puts "#{player.name} переміг"
    player.add_win

    loser = (player == @player1) ? @player2 : @player1
    loser.add_loss
  end

  def end_game_with_draw
    @player1.add_draw
    @player2.add_draw
    puts "Нічия"
  end
end
