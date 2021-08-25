# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../main'

##
# Tests for #valid_space?
RSpec.describe '#valid_space?' do
  it '[0, 0] - [7, 7] diagonal spaces are valid' do
    8.times { |i| expect(valid_space?([i, i])).to eq(true) }
  end

  it 'All other board spaces in the 8 x 8 board are valid' do
    ((0..7).to_a * 2).combination(2) do |space|
      expect(valid_space?(space)).to eq(true)
    end
  end

  it 'negative values are not allowed' do
    expect(valid_space?([-1, 0])).to eq(false)
    expect(valid_space?([0, -1])).to eq(false)
  end
end

RSpec.describe '#valid_knight_moves' do
  context 'given invalid spaces' do
    it 'returns empty array' do
      expect(valid_knight_moves([-1, 1])).to eq([])
    end
  end

  ##
  # These tests are derived from the diagram found at
  # https://en.wikipedia.org/wiki/Knight%27s_tour#/media/File:Knight's_graph_showing_number_of_possible_moves.svg
  # to ensure the correct number of valid spaces for certain
  # portions of the board.
  context 'given valid spaces' do
    it 'returns 2 moves for corners' do
      [0, 7].repeated_permutation(2) do |corner|
        expect(valid_knight_moves(corner).length).to eq(2)
      end
    end

    it 'returns 3 moves for near-corner edges' do
      places = [[0, 1], [1, 0], [0, 6], [6, 0], [7, 6], [6, 7], [1, 7], [7, 1]]
      places.each do |space|
        expect(valid_knight_moves(space).length).to eq(3)
      end
    end

    it 'returns 4 moves for inner edges and some corners' do
      places = [1, 6].repeated_permutation(2).to_a
      (2..5).each do |value|
        places.append([0, value])
        places.append([value, 0])
        places.append([7, value])
        places.append([value, 7])
      end

      places.each do |space|
        expect(valid_knight_moves(space).length).to eq(4)
      end
    end

    it 'returns 6 moves for inner-inner edges, minus corners' do
      places = []
      (2..5).each do |value|
        places.append([1, value])
        places.append([value, 1])
        places.append([6, value])
        places.append([value, 6])
      end

      places.each do |space|
        expect(valid_knight_moves(space).length).to eq(6)
      end
    end

    it 'returns 8 moves for inner square' do
      [2, 3, 4, 5].repeated_permutation(2) do |space|
        expect(valid_knight_moves(space).length).to eq(8)
      end
    end

    it 'returns the correct moves for [0, 0]' do
      expected_output = [[1, 2], [2, 1]]
      actual_output = valid_knight_moves([0, 0])
      expect(actual_output).to eq(expected_output)
    end

    it 'returns the correct moves for [3, 3]' do
      # Sort since order isn't particulalrly important
      expected_output = [[1, 2], [2, 1], [1, 4], [4, 1], [2, 5], [5, 2], [5, 4], [4, 5]].sort
      actual_output = valid_knight_moves([3, 3]).sort
      expect(actual_output).to eq(expected_output)
    end
  end
end

RSpec.describe '#find_knight_path' do
  context 'given the same starting and ending space' do
    it 'returns just the starting space' do
      expect(find_knight_path([0, 0], [0, 0])).to eq([[0, 0]])
    end
  end

  context 'given 1 space away' do
    it 'returns a path length 1 for [0, 0] to [1, 2]' do
      expect(find_knight_path([0, 0], [1, 2]).length).to eq(2)
    end

    it 'returns a path of length 1 for [1, 2] to [0, 4]' do
      expect(find_knight_path([1, 2], [0, 4]).length).to eq(2)
    end
  end

  context 'traveling diagonally from corner to corner' do
    it 'returns a path length of 6' do
      corners = [[[0, 0], [7, 7]], [[0, 7], [7, 0]]]
      corners.each do |corner_pair|
        # Opposite corners traversed both ways
        expect(find_knight_path(corner_pair[0], corner_pair[1]).length).to eq(7)
        expect(find_knight_path(corner_pair[1], corner_pair[0]).length).to eq(7)
      end
    end
  end

  context 'traveling along the edges from corner to corner' do
    it 'returns a path length of 5' do
      corners = [[[0, 0], [0, 7]], [[0, 0], [7, 0]],
                 [[0, 7], [7, 7]], [[7, 0], [7, 7]]]
      corners.each do |corner_pair|
        # Corner to corner traversed both ways
        expect(find_knight_path(corner_pair[0], corner_pair[1]).length).to eq(6)
        expect(find_knight_path(corner_pair[1], corner_pair[0]).length).to eq(6)
      end
    end
  end
end

RSpec.describe '#knight_moves' do
  context 'given valid inputs' do
    it 'prints the path from [0, 0] to [1, 2]' do
      expect do
        knight_moves([0, 0], [1, 2])
      end.to output("You got from [0, 0] to [1, 2] in 1 move!\nHere is your path:\n\t  [0, 0]\n\t↪ [1, 2]\n").to_stdout
    end

    it 'prints the path from [0, 0] to [5, 6]' do
      expect do
        knight_moves([0, 0], [5, 6])
      end.to output("You got from [0, 0] to [5, 6] in 5 moves!
Here is your path:\n\t  [0, 0]\n\t↪ [1, 2]\n\t↪ [2, 4]\n\t↪ [3, 6]\n\t↪ [4, 4]\n\t↪ [5, 6]\n").to_stdout
    end
  end

  context 'given invalid inputs' do
    it 'returns nil for invalid target space' do
      expect(knight_moves([0, 0], [-1, 2])).to eq(nil)
    end

    it 'returns nil for invalid initial space' do
      expect(knight_moves([-1, -1], [1, 2])).to eq(nil)
    end

    it 'returns nil if both spaces are invalid' do
      expect(knight_moves([-1, 0], [10, 1])).to eq(nil)
    end

    it 'outputs error message' do
      expect do
        knight_moves([-1, 0], [0, 0])
      end.to output("Please ensure that initial space and target space are valid board positions\nChoose any point from (0..7) x (0..7).\n").to_stdout
    end
  end
end
