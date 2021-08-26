# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'
require_relative '../lib/tic_tac_toe'

RSpec.describe TicTacToe do
  let(:game) { TicTacToe.new }
  describe '#intialize' do
    it 'creates player objects with X/O markers' do
      expect(game.players.length).to be 2
      expect(game.players[0].marker).to be 'X'
      expect(game.players[1].marker).to be 'O'
    end

    it 'starts with all free slots' do
      expect(game.free_slots).to be 9
    end
  end

  describe '#won?' do
    # Test #won? under each winning condition
    TicTacToe::WINNING_LOCATIONS.each do |line|
      it "returns true when #{line} are all X" do
        game.increment_player_idx # Change current player to be X
        line.each { |loc| game.board[loc].fill_char = 'X' }
        expect(game.won?).to be true
      end

      it "returns true when #{line} are all O" do
        line.each { |loc| game.board[loc].fill_char = 'O' }
        expect(game.won?).to be true
      end
    end
  end

  describe '#clear_board' do
    it 'clears all the makers' do
      game.board.each do |_loc, slot|
        slot.fill_char = 'X'
      end
      game.clear_board
      game.board.each do |_loc, slot|
        expect(slot.fill_char).to be '_'
      end
    end

    it 'returns free_spaces, which should be 9' do
      expect(game.clear_board).to be 9
    end
  end

  describe '#play_round' do
    # Intercept stdin and stdout for testing
    $stdin = StringIO.new
    $stdout = StringIO.new

    it 'plays a game to victory for X' do
      allow($stdin).to receive(:gets).and_return('A1', 'A2', 'B1', 'B2', 'C1', '\n', 'q')
      game.play_round
      expect(game.players[0].score).to be 1
    end

    it 'plays a game to victory for O' do
      allow($stdin).to receive(:gets).and_return('A1', 'A2', 'B1', 'B2', 'C3', 'C2', '\n',\
                                                 'q')
      game.play_round
      expect(game.players[1].score).to be 1
    end

    it 'plays a game to a tie' do
      allow($stdin).to receive(:gets).and_return('A1', 'B1', 'A2', 'B2', 'B3', 'A3', 'C1',\
                                                 'C2', 'C3', '\n', 'q')
      game.play_round
      game.players.each { |player| expect(player.score).to be 0 }
    end

    it 'plays a game to a tie and then to an O victory' do
      allow($stdin).to receive(:gets).and_return('A1', 'B1', 'A2', 'B2', 'B3', 'A3', 'C1',\
                                                 'C2', 'C3', '\n', 'A1', 'A2', 'B1', 'B2',\
                                                 'C1', '\n', 'q')
      game.play_round
      expect(game.players[1].score).to be 1
    end

    it 'exits the game before any victory' do
      allow($stdin).to receive(:gets).and_return('A1', 'B1', 'q')
      game.play_round
      game.players.each { |player| expect(player.score).to be 0 }
    end

    it 'plays a game to victory for X with some invalid locations' do
      allow($stdin).to receive(:gets).and_return('CC', 'A1', 'A2', 'D1', 'B1', 'B2', 'C1',\
                                                 '\n', 'q')
      game.play_round
      expect(game.players[0].score).to be 1
    end
  end
end
