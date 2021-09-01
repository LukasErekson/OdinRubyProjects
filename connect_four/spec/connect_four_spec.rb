# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/connect_four'

RSpec.describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#play' do
    context 'when a game is played to completion' do
      before do
        $stdin = StringIO.new
        $stdout = StringIO.new
      end

      it 'breaks the input loop' do
        expect($stdin).to receive(:gets).exactly(7).times.and_return('1', '1', '2', '2', '3', '3', '4')
        game.play
      end

      it 'increments player 1\'s score when they win' do
        allow($stdin).to receive(:gets).exactly(7).times.and_return('1', '1', '2', '2', '3', '3', '4')
        expect { game.play }.to change { game.player1.score }.by(1)
      end

      it 'increments player 2\'s score when they win' do
        allow($stdin).to receive(:gets).exactly(10).times.and_return('1', '1', '2', '2', '3', '3', '5', '4', '5', '4')
        expect { game.play }.to change { game.player2.score }.by(1)
      end
    end

    context 'when the game ends prematurely' do
      it 'breaks the loop' do
        expect($stdin).to receive(:gets).exactly(6).times.and_return('1', '1', '2', '2', '3', 'quit')
        game.play
      end

      it 'prompts the user to save' do
        expect($stdin).to receive(:gets).exactly(6).times.and_return('1', '1', '2', '2', '3', 'quit')
        game.play
      end
    end
  end
end
