describe Game do
  let(:empty_grid) { Array.new(6) { Array.new(7, ' ') } }
  let(:game) { Game.new(empty_grid) }
  describe '#in_bounds?' do
    it 'returns true for valid position' do
      expect(game.in_bounds?([0, 0])).to be true
      expect(game.in_bounds?([5, 6])).to be true
    end

    it 'returns nil or false for invalid position' do
      expect(game.in_bounds?([-1, 0])).to be_nil
      expect(game.in_bounds?([6, 7])).to be_nil
    end
  end

  describe '#check_win' do
    it 'detects vertical win' do
      4.times { |i| game.grid[5 - i][0] = 'x' }
      game.last_position = [5, 0]

      game.check_win(game.last_position)

      expect(game.game_finished).to be true
    end

    it 'detects horizontal win' do
      4.times { |i| game.grid[5][i] = 'x' }
      game.last_position = [5, 3]

      game.check_win(game.last_position)

      expect(game.game_finished).to be true
    end
  end
end