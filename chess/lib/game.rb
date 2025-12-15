require 'yaml'

class Game
  attr_reader :player1, :player2
  attr_accessor :current_player, :board

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player2
  end

  def load
    if File.exist?('saved_games/game_1.yaml')
      saved_game = File.open('saved_games/game_1.yaml') { |f|
        YAML.safe_load(
          f,
          aliases: true,
          permitted_classes: [
            Symbol,
            Board,
            Rook,
            King,
            Queen,
            Bishop,
            Knight,
            Pawn,
            Player
          ]
        )
      }
      @board = saved_game[0]
      @current_player = saved_game[1]
    else
      puts "Немає збережених ігор"
    end
  end

  def over?
    board.checkmate?
  end

  def play
    board.render
    until over?
      turn_play
      board.render
      switch_player!
    end
  end

  def switch_player!
    @current_player = current_player == player1 ? player2 : player1
  end

  def turn_play
    start_pos = get_start
    make_move(start_pos)
    system('clear') || system('cls')
  end

  private

  def get_start(start_pos = nil)
    loop do
      puts "Хід #{current_player.color.capitalize}'. Оберіть фігуру."
      start_pos = current_player.get_pos
      unless start_pos.include?(nil) || board[start_pos].nil?
        if board[start_pos].color == current_player.color
          break
        end
      end
      puts "Поимлка: Оберіть #{current_player.color} фігуру."
    end
    start_pos
  end

  def make_move(start_pos = nil)
    numbers = ('1'..'8').to_a.reverse!
    letters = ('a'..'h').to_a
    r, c = start_pos
    l = letters[c]
    n = numbers[r]
    loop do
      puts "Введіть [1] щоб змінити фігуру. Наразі обрано #{l + n}...
      [Any Key] щоб продовжити...
      [save] щоб зберегти гру."
      selection = gets.chomp
      if selection.to_i == 1
        start_pos = get_start
      elsif selection.downcase == 'save'
        save([@board, @current_player])
      end
      puts 'Оберіть клітинку для входу:'
      end_pos = current_player.get_pos
      begin
        board.move_piece(start_pos, end_pos)
        break
      rescue RuntimeError
        puts "Помилка: Неможливо обрати цю клітинку."
      end
    end
  end

  def save(objects)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    yaml = YAML.dump(objects)
    File.open('saved_games/game_1.yaml', 'w') { |f| f.puts yaml }
  end
end
