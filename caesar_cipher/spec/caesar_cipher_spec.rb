# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../caesar_cipher'

RSpec.describe '#caesar_cipher' do
  let(:plain_text) { 'I have a bad feeling about this.' }
  context 'when given multiples of 26' do
    it 'returns original message' do
      4.times do |i|
        expect(caesar_cipher(plain_text, 26*(i-2))).to eq(plain_text)
      end
    end
  end
end