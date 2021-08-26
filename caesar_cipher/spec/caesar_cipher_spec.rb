# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../caesar_cipher'

RSpec.describe '#caesar_cipher' do
  let(:plaintext) { 'I have a bad feeling about this.' }
  # Catch $stderr to ensure warnings work
  $stderr = StringIO.new

  context 'when given multiples of 26' do
    3.times do |i|
      shift = 26 * (i - 2)

      it "returns original message for shift = #{shift}" do
        expect(caesar_cipher(plaintext, shift)).to eq(plaintext)
      end

      it "warns about the ciphertext equaling the plaintext for shift = #{shift}" do
        $stderr.rewind
        expect($stderr.readlines[i].include?("The ciphertext is identical to the message. (#{shift} % 26 == 0)")).to be true
      end
    end
  end

  context 'when given positve shift values' do
    it 'returns shifted ciphertext' do
      ciphertext = 'Z yrmv r sru wvvczex rsflk kyzj.'
      expect(caesar_cipher(plaintext, 17)).to eq ciphertext
    end
  end

  context 'when given negative shift values' do
    it 'returns shifted ciphertext' do
      ciphertext = 'Z yrmv r sru wvvczex rsflk kyzj.'
      expect(caesar_cipher(plaintext, -9)).to eq ciphertext
    end
  end

  context 'when given punctation characters' do
    it 'returns unlatered string' do
      expect(caesar_cipher('.,!></?&%@#*', 5)).to eql '.,!></?&%@#*'
    end
  end
end
