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
          described_class.new(Player.new('Bob', 'X'))
        end.not_to raise_error(proc { StandardError.new })
      end
      it 'accepts two Player objects' do
        expect do
          described_class.new(Player.new('Bob', '☻'), Player.new('Rick', '☺'))
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

  describe '#get_player_input' do
    before do
      $stdin = StringIO.new
    end

    context 'when given valid input' do
      10.times do |i|
        it "returns an integer mapping #{i} to #{i - 1}" do
          allow($stdin).to receive(:gets).and_return(i.to_s)
          actual_input = game_board.get_player_input
          expect(actual_input).to eq(i - 1)
        end
      end

      it 'returns "quit" when given "exit"' do
        allow($stdin).to receive(:gets).and_return('exit')
        expect(game_board.get_player_input).to eq('quit')
      end

      it 'returns "quit" when given "quit"' do
        allow($stdin).to receive(:gets).and_return('quit')
        expect(game_board.get_player_input).to eq('quit')
      end

      it 'returns "quit" when given "q"' do
        allow($stdin).to receive(:gets).and_return('q')
        expect(game_board.get_player_input).to eq('quit')
      end

      it 'returns "quit" when given "EXIT"' do
        allow($stdin).to receive(:gets).and_return('EXIT')
        expect(game_board.get_player_input).to eq('quit')
      end

      it 'returns "quit" when given "QUIT"' do
        allow($stdin).to receive(:gets).and_return('QUIT')
        expect(game_board.get_player_input).to eq('quit')
      end

      it 'returns "quit" when given "Q"' do
        allow($stdin).to receive(:gets).and_return('Q')
        expect(game_board.get_player_input).to eq('quit')
      end
    end

    context 'when given invalid input' do
      it 'returns nil for a string "abc"' do
        allow($stdin).to receive(:gets).and_return('abc')
        expect(game_board.get_player_input).to eq(nil)
      end

      it 'returns nil for an empty string' do
        allow($stdin).to receive(:gets).and_return('')
        expect(game_board.get_player_input).to eq(nil)
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

      it 'decreases available slots' do
        expect { game_board.fill_slot(2) }.to change(game_board, :available_slots).by(-1)
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

  describe '#won?' do
    before do
      $stdin = StringIO.new
    end

    context 'when the game isn\'t over' do
      it 'returns false' do
        expect(game_board.won?).to be(false)
      end
    end

    context 'when games are played to completion' do
      it 'returns true for a vertical win' do
        allow($stdin).to receive(:gets).and_return('1', '2', '1', '2', '1', '2', '1')
        7.times do
          game_board.fill_slot(game_board.get_player_input)
          game_board.increment_turn
        end
        # Increment turn to make sure it's checking for the right player
        game_board.increment_turn
        expect(game_board.won?).to be(true)
      end

      it 'returns true for a horizontal win' do
        allow($stdin).to receive(:gets).and_return('1', '1', '2', '2', '3', '3', '4')
        7.times do
          game_board.fill_slot(game_board.get_player_input)
          game_board.increment_turn
        end
        # Increment turn to make sure it's checking for the right player
        game_board.increment_turn
        expect(game_board.won?).to be(true)
      end

      it 'returns true for a / diagonal win' do
        allow($stdin).to receive(:gets).and_return('1', '2', '2', '3', '3', '6', '3', '4', '4', '4', '4')
        11.times do
          game_board.fill_slot(game_board.get_player_input)
          game_board.increment_turn
        end
        # Increment turn to make sure it's checking for the right player
        game_board.increment_turn
        expect(game_board.won?).to be(true)
      end

      it 'returns true for a \ diagonal win' do
        allow($stdin).to receive(:gets).and_return('5', '4', '4', '3', '3', '1', '3', '2', '2', '2', '2')
        11.times do
          game_board.fill_slot(game_board.get_player_input)
          game_board.increment_turn
        end
        # Increment turn to make sure it's checking for the right player
        game_board.increment_turn
        expect(game_board.won?).to be(true)
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

    context 'when the board has some slots marked' do
      it 'returns a board with player tokens in place' do
        expected_output = <<~BOARD
          =================
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          | O O O O O O O |
          | O O O O ☻ O O |
          | O O ☻ ☺ ☺ O O |
          =================
            1 2 3 4 5 6 7
        BOARD
        # Play a couple slots
        [4, 3, 5, 5].each do |slot|
          game_board.fill_slot(slot - 1)
          game_board.increment_turn
        end
        expect(game_board.to_s).to eq(expected_output)
      end
    end
  end
end
