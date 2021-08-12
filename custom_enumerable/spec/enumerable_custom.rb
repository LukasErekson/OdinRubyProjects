# frozen_string_literal: true

require 'spec_helper'
require_relative '../my_enumerable.rb'

RSpec.describe 'Custom Enumerable Methods' do
  num_array = [1, 3, 4, 5]
  str_array = %w[this is my array of words]
  hash = { name: 'hash', color: 'red', easy: false }

  describe 'each method' do
    it 'prints number arrays' do
      expect($stdout).to receive(:puts).with(1)
      expect($stdout).to receive(:puts).with(3)
      expect($stdout).to receive(:puts).with(4)
      expect($stdout).to receive(:puts).with(5)
      num_array.my_each { |val| puts val }
    end

    it 'prints string arrays' do
      expect($stdout).to receive(:puts).with('this')
      expect($stdout).to receive(:puts).with('is')
      expect($stdout).to receive(:puts).with('my')
      expect($stdout).to receive(:puts).with('array')
      expect($stdout).to receive(:puts).with('of')
      expect($stdout).to receive(:puts).with('words')
      str_array.my_each { |word| puts word }
    end

    it 'prints hash values and keys' do
      expect($stdout).to receive(:puts).with('name : hash')
      expect($stdout).to receive(:puts).with('color : red')
      expect($stdout).to receive(:puts).with('easy : false')
      hash.my_each do |key, value|
        puts "#{key} : #{value}"
      end
    end
  end
end
