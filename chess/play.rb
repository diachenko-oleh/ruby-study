require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/player'

b = Board.new
b.set_board
p1 = Player.new(:black)
p2 = Player.new(:white)
game = Game.new(b, p1, p2)

puts 'Введіть [1] щоб завантажити гру або [2] щоб почати нову'
selection = gets.chomp.to_i
case selection
when 1
  game.load
  game.play
when 2
  game.play
end