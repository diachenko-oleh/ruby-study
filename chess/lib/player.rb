class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_pos
    numbers = ('1'..'8').to_a.reverse!
    letters = ('a'..'h').to_a
    loc = gets.chomp.split('')
    c, r = loc
    row = numbers.index(r)
    column = letters.index(c)
    [row, column]
  end
end
