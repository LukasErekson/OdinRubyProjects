# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'
require_relative '../lib/value_error'

RSpec.describe Player do
  let(:player_x) { Player.new('X') }

  describe '#initialize' do
    context 'given valid arguments' do
      valid_player = Player.new('X', 'Mark')

      it 'assigns marker correctly' do
        expect(valid_player.marker).to be 'X'
      end

      it 'assigns name correctly' do
        expect(valid_player.name).to be 'Mark'
      end

      it 'assigns score correctly' do
        expect(valid_player.score).to be 0
      end
    end

    context 'given an invalid marker' do
      let(:val_err) { ValueError.new('fill_char must be of length 1 and not "_"') }

      it 'rasies ValueError for empty string' do
        expect { Player.new('') }.to raise_error(proc { val_err })
      end

      it 'raises ValueError for longer string' do
        expect { Player.new('abv') }.to raise_error(proc { val_err })
      end

      it 'raises ValueError for Array' do
        expect { Player.new(['X']) }.to raise_error(proc { val_err })
      end

      it 'raises ValueError for Hash' do
        expect { Player.new({ A: 'A' }) }.to raise_error(proc { val_err })
      end
    end
  end

  describe '#increment_score' do
    it 'increments the score once' do
      expect(player_x.increment_score).to be 1
      expect(player_x.score).to be 1
    end

    it 'increments the score multiple times' do
      rand_int = rand(2..10)
      rand_int.times { |_| player_x.increment_score }
      expect(player_x.score).to be rand_int
    end
  end

  describe '#to_s' do
    it 'returns player name, marker, and score' do
      expect(player_x.to_s).to eq('Player (X): 0')
    end
  end
end
