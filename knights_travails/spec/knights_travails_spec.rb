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
end
