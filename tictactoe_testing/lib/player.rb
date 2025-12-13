class Player
  attr_reader :id, :wins, :losses, :draws
  attr_accessor :name

  def initialize(name)
    @name = name
    @wins = 0 
    @losses = 0 
    @draws = 0 
  end

  def add_win
    @wins += 1
  end

  def add_loss
    @losses += 1
  end

  def add_draw
    @draws += 1
  end

  def get_stats
    print "Перемог: #{@wins} "
    print "Програшів: #{@losses} "
    print "Нічий: #{@draws} "
  end
end