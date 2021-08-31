# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new }

  describe '#initialize' do
    context 'when name is not a string' do
      it 'raises an error' do
        expect { described_class.new(5).name }.to raise_error(proc { StandardError.new })
      end
    end

    context 'when token is not a string' do
      it 'raises an error' do
        expect { described_class('player', :token) }.to raise_error(proc { StandardError.new })
      end
    end

    context 'when the token is "O"' do
      it 'raises an error' do
        expect { described_class('Player', 'O') }.to raise_error(proc { StandardError.new })
      end
    end
  end

  describe '#increment_score' do
    it 'increments the score by 1' do
      expect { player.increment_score }.to change(player, :score).by(1)
    end
  end

  describe '#to_s' do
    it 'returns name, token, and score' do
      expect(player.to_s).to eq('Player (⚪): 0')
    end
  end
end
