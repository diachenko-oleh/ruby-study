require 'yaml'
require_relative '../lib/game'

describe Game do
  let(:board) { instance_double(Board) }
  let(:player1) { instance_double(Player, color: 'white') }
  let(:player2) { instance_double(Player, color: 'black') }

  subject(:game) { described_class.new(board, player1, player2) }

  describe '#initialize' do
    it 'sets board and players' do
      expect(game.board).to eq(board)
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
    end

    it 'starts with player2 as current player' do
      expect(game.current_player).to eq(player2)
    end
  end

  describe '#switch_player!' do
    it 'switches from player2 to player1' do
      game.switch_player!
      expect(game.current_player).to eq(player1)
    end

    it 'switches back from player1 to player2' do
      game.switch_player!
      game.switch_player!
      expect(game.current_player).to eq(player2)
    end
  end

  describe '#over?' do
    it 'returns true if board is in checkmate' do
      allow(board).to receive(:checkmate?).and_return(true)
      expect(game.over?).to be true
    end

    it 'returns false if board is not in checkmate' do
      allow(board).to receive(:checkmate?).and_return(false)
      expect(game.over?).to be false
    end
  end

  describe '#load' do
    let(:loaded_board) { instance_double(Board) }
    let(:loaded_player) { instance_double(Player) }

    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:safe_load)
        .and_return([loaded_board, loaded_player])
    end

    it 'loads board and current player from file' do
      game.load
      expect(game.board).to eq(loaded_board)
      expect(game.current_player).to eq(loaded_player)
    end
  end

  describe '#save' do
    let(:objects) { [board, player1] }

    before do
      allow(Dir).to receive(:exist?).and_return(true)
      allow(File).to receive(:open)
      allow(YAML).to receive(:dump).and_return('yaml-content')
    end

    it 'writes game state to yaml file' do
      expect(File).to receive(:open)
        .with('saved_games/game_1.yaml', 'w')

      game.send(:save, objects)
    end
  end
end
