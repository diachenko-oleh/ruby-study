require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/tictactoe'

describe 'Tic Tac Toe' do
  let(:empty_board) { Array.new(3) { Array.new(3, "-") } }
  let(:board) { Board.new(empty_board) }

  describe Board do
    describe '#new_move and #check_sq' do
      it 'places a marker on the board' do
        board.new_move(0, 0, "X")
        expect(board.check_sq(0, 0)).to eq("X")
      end
    end
    describe '#check_win' do
      context 'when a player wins horizontally' do
        it 'detects a win in the top row' do
          board.new_move(0, 0, "X")
          board.new_move(0, 1, "X")
          board.new_move(0, 2, "X")

          expect(board.check_win("X")).to be true
        end
      end

      context 'when a player wins vertically' do
        it 'detects a win in the first column' do
          board.new_move(0, 0, "0")
          board.new_move(1, 0, "0")
          board.new_move(2, 0, "0")

          expect(board.check_win("0")).to be true
        end
      end

      context 'when a player wins diagonally' do
        it 'detects a main diagonal win' do
          board.new_move(0, 0, "X")
          board.new_move(1, 1, "X")
          board.new_move(2, 2, "X")

          expect(board.check_win("X")).to be true
        end

        it 'detects a reverse diagonal win' do
          board.new_move(2, 0, "0")
          board.new_move(1, 1, "0")
          board.new_move(0, 2, "0")

          expect(board.check_win("0")).to be true
        end
      end

      context 'when there is no winner' do
        it 'returns false' do
          board.new_move(0, 0, "X")
          board.new_move(0, 1, "0")
          board.new_move(0, 2, "X")

          expect(board.check_win("X")).to be false
          expect(board.check_win("0")).to be false
        end
      end
    end
  end






  describe Player do
    let(:player) { Player.new("TestPlayer") }

    it 'initializes with zero stats' do
      expect(player.wins).to eq(0)
      expect(player.losses).to eq(0)
      expect(player.draws).to eq(0)
    end

    it 'increments wins' do
      player.add_win
      expect(player.wins).to eq(1)
    end

    it 'increments losses' do
      player.add_loss
      expect(player.losses).to eq(1)
    end

    it 'increments draws' do
      player.add_draw
      expect(player.draws).to eq(1)
    end
  end





  describe Game do
    it 'ends the game when someone wins' do
      board = instance_double(Board)

      allow(board).to receive(:check_sq).and_return("-")
      allow(board).to receive(:new_move)
      allow(board).to receive(:print_board)
      allow(board).to receive(:check_win).and_return(true)

      game = Game.new
      game.instance_variable_set(:@board, board)

      allow(game).to receive(:gets).and_return("0 0\n")

      expect { game.play }.to output(/переміг/).to_stdout
    end
  end
end