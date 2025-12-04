require_relative 'lib/board'
require_relative 'lib/player'

def make_move(marker,board)
    while true
      puts "Введіть координати для вашого '#{marker}' через пробіл. Значення має бути в діапазоні [0,2]"
      coords = gets.chomp.split()
      temp_i = coords[0].to_i
      temp_j = coords[1].to_i
      if (0..2).cover?(temp_i) && (0..2).cover?(temp_j)
        i = temp_i
        j = temp_j
        if(board.check_sq(i,j)=="-")
          board.new_move(i,j,marker)
          break
        else
          puts "Місце зайняте!"

        end
      else
        puts "Непідходящі значення!"
      end
    end
end


b = Array.new(3) { Array.new(3,"-") }

board = Board.new(b)
empty_sq = 9

player1 = Player.new("player1")
player2 = Player.new("player2")
zero_turn = true
is_result = false

while empty_sq>0 do
  if zero_turn      
    make_move("0",board)

    if board.check_win("0")
      board.print_board
      puts "#{player1.name} переміг"
      is_result = true
      player1.add_win
      player2.add_loss
      break
    end
  else
    make_move("X",board)

    if board.check_win("X")
      board.print_board
      puts "#{player2.name} переміг"
      is_result = true
      player2.add_win
      player1.add_loss
      break
    end
  end
  board.print_board
  empty_sq -= 1 
  zero_turn = !zero_turn
end

if(!is_result)
    player1.add_draw
    player2.add_draw
    puts "Нічия"
end

player1.get_stats
puts
player2.get_stats
puts