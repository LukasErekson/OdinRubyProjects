# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/game_board'
require_relative '../lib/player'
require_relative '../lib/invalid_col_error'

RSpec.describe GameBoard do
  subject(:game_board) { described_class.new }

  describe '#initialize' do
    context 'given Player objects as arguments' do
      it 'accepts one Player object' do
        expect do
          described_class.new(Player.new('Bob', '⚪'))
        end.not_to raise_error(proc { StandardError.new })
      end

      it 'accepts two Player objects' do
        expect do
          described_class.new(Player.new('Bob', '⚪'), Player.new('Rick', '⚫'))
        end.not_to raise_error(proc { StandardError.new })
      end
    end

    context 'given non-Player objects' do
      it 'raises an error for the first parameter' do
        expect do
          described_class.new('Richard')
        end.to raise_error(proc { StandardError.new })
      end

      it 'raises an error for the second parameter' do
        expect do
          described_class.new(Player.new('Bill'), 'Rick')
        end.to raise_error(proc { StandardError.new })
      end
    end

    context 'when verifying unique tokens' do
      it 'rasies an error if tokens are not unique' do
        expect do
          described_class.new(Player.new('Bill', 'X'), Player.new('Rick', 'X'))
        end.to raise_error(proc { StandardError.new })
      end

      it 'does not raise an error if tokens are unique' do
        expect { game_board }.not_to raise_error(proc { StandardError.new })
      end
    end
  end

  describe '#increment_turn' do
    context 'when it was player 1\'s turn' do
      it 'changes the index to be 1' do
        expect { game_board.increment_turn }.to change(game_board, :current_player_index).from(0).to(1)
      end
    end

    context 'when it was player 2\'s turn' do
      it 'changes the index to be 0' do
        game_board.increment_turn
        expect { game_board.increment_turn }.to change(game_board, :current_player_index).from(1).to(0)
      end
    end
  end

  describe '#fill_slot' do
    context 'given a column with available space' do
      slot = 5
      6.times do |i|
        place_board = described_class.new
        i.times do
          place_board.fill_slot(slot)
          place_board.increment_turn
        end
        it "places player #{(i % 2) + 1}\'s token in the right slot" do
          expected_output = place_board.players[place_board.current_player_index].token
          board = place_board.instance_variable_get(:@board)
          expect do
            place_board.fill_slot(slot)
          end.to change { board[slot][i] }.from('O').to(expected_output)
        end
      end
    end

    context 'given a valid column with no available space' do
      it 'rasies a InvalidColumnError' do
        place_board = described_class.new
        slot = 5
        6.times do
          place_board.fill_slot(slot)
          place_board.increment_turn
        end
        expect do
          place_board.fill_slot(slot)
        end.to raise_error(proc { InvalidColumnError.new('5', 'full') })
      end
    end

    context 'given an invalid column' do
      it 'raises an InvalidColumnError' do
        slot = 8
        expect do 
          board.fill_slot(slot)
        end.to raise_error(proc { InvalidColumnError.new('8', 'range') })
      end
    end
  end

  describe '#to_s' do
    context 'when the board is empty' do
      it 'returns an empty 6 x 7 board' do
        expected_output = <<~BOARD
          =================
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          =================
            1 2 3 4 5 6 7
        BOARD
        expect(game_board.to_s).to eq(expected_output)
      end
    end
  end
end
