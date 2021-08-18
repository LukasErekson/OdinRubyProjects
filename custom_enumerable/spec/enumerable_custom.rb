# frozen_string_literal: true

require 'spec_helper'
require_relative '../my_enumerable'

RSpec.describe 'Custom Enumerable Methods' do
  num_array = [1, 3, 4, 5]
  str_array = %w[this is my array of words]
  hash = { name: 'hash', color: 'red', easy: false }
  nested_array = [[1, 2], [3, 4, 5]]
  nested_hash = { first: { name: 'flash', power: 'speed' },\
                  second: { name: 'grog', power: 'himbo' } }

  describe '1.#my_each method' do
    context 'Example structures:' do
      it 'prints integer arrays correctly' do
        num_array.each do |num|
          expect($stdout).to receive(:puts).with(num)
        end
        num_array.my_each { |val| puts val }
      end

      it 'prints string arrays correctly' do
        str_array.each do |str|
          expect($stdout).to receive(:puts).with(str)
        end
        str_array.my_each { |word| puts word }
      end

      it 'prints hash values and keys correctly' do
        hash.each do |key, value|
          expect($stdout).to receive(:puts).with("#{key} : #{value}")
        end
        hash.my_each do |key, value|
          puts "#{key} : #{value}"
        end
      end
    end

    context 'Edge cases:' do
      it 'Empty array- prints nothing and returns empty array' do
        [].each do |n|
          expect($stdout).to receive(:puts).with(n)
        end
        expect([].my_each { |n| puts n }).to eq([])
      end

      it 'Empty hash - prints nothing and returns empty hash' do
        {}.each do |_k, _v|
          expect($stdout).to receive(:puts).with(o)
        end
        expect({}.my_each { |k, _v| puts k }).to eq({})
      end
    end

    context 'Nested structures:' do
      it 'Nested arrays - prints correctly and returns nested array' do
        nested_array.each { |n| expect($stdout).to receive(:puts).with(n) }
        expect(nested_array.my_each { |val| puts val }).to eq(nested_array)
      end

      it 'Nested hashes - prints correctly and returns nested hash' do
        nested_hash.each { |k, v| expect($stdout).to receive(:puts).with("#{k}:#{v}") }
        expect(nested_hash.my_each { |k, v| puts "#{k}:#{v}" }).to eq(nested_hash)
      end
    end
  end

  describe '2.#my_each_with_index method' do
    context 'Example structures:' do
      it 'Prints integer arrays with indices' do
        num_array.each_with_index { |val, idx| expect($stdout).to receive(:puts).with("#{idx}:#{val}") }
        num_array.my_each_with_index { |val, idx| puts "#{idx}:#{val}" }
      end

      it 'Prints string arrays with indices' do
        str_array.each_with_index { |val, idx| expect($stdout).to receive(:puts).with("#{idx}:#{val}") }
        str_array.my_each_with_index { |val, idx| puts "#{idx}:#{val}" }
      end

      it 'Prints hash pairs and indices' do
        hash.each_with_index do |pair, idx|
          expect($stdout).to receive(:puts).with("#{pair} : #{idx}")
        end
        hash.my_each_with_index do |pair, idx|
          puts "#{pair} : #{idx}"
        end
      end
    end

    context 'Edge cases:' do
      it 'Empty arrays' do
        [].each_with_index do |val, idx|
          expect($stdout).to receive(:puts).with("#{idx}:#{val}")
        end
        [].my_each_with_index { |val, idx| "#{idx}:#{val}" }
      end

      it 'Empty hashes' do
        {}.each_with_index do |val, idx|
          expect($stdout).to receive(:puts).with("#{idx}:#{val}")
        end
        {}.my_each_with_index { |val, idx| "#{idx}:#{val}" }
      end
    end

    context 'Nested structures:' do
      it 'works with nested arrays' do
        nested_array.each_with_index { |val, idx| expect($stdout).to receive(:puts).with("#{idx}:#{val}") }
        nested_array.my_each_with_index { |val, idx| puts "#{idx}:#{val}" }
      end

      it 'works with nested hashes' do
        nested_hash.each_with_index { |val, idx| expect($stdout).to receive(:puts).with("#{idx}:#{val}") }
        nested_hash.my_each_with_index { |val, idx| puts "#{idx}:#{val}" }
      end
    end
  end

  describe '3.#my_select method' do
    context 'Example structures:' do
      it 'Selects from integer arrays' do
        select_criterion = ->(number) { number.between?(2, 5) }
        expected_output = num_array.select { |val| select_criterion.call(val) }
        expect(num_array.my_select { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Selects from string arrays' do
        select_criterion = ->(str) { str.include?('y') }
        expected_output = str_array.select { |val| select_criterion.call(val) }
        expect(str_array.my_select { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Selects from hashes' do
        select_criterion = ->(_key, val) { val.is_a? String }
        expected_output = hash.select { |key, val| select_criterion.call(key, val) }
        expect(hash.my_select { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end

    context 'Edge cases:' do
      it 'Empty arrays just return empty arrays' do
        select_criterion = ->(val) { val.nil? }
        expected_output = [].select { |val| select_criterion.call(val) }
        expect([].my_select { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Empty hashes just return empty hashes' do
        select_criterion = ->(_key, val) { val.nil? }
        expected_output = {}.select { |key, val| select_criterion.call(key, val) }
        expect({}.my_select { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end

    context 'Nested structures:' do
      it 'Selects in nested arrays' do
        select_criterion = ->(val) { val.length > 2 }
        expected_output = nested_array.select { |val| select_criterion.call(val) }
        expect(nested_array.my_select { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Selects in nested hashes' do
        select_criterion = ->(_key, val) { val.length > 2 }
        expected_output = nested_hash.select { |key, val| select_criterion.call(key, val) }
        expect(nested_hash.my_select { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end
  end

  describe '4.#my_all? method' do
    context 'Example structures' do
      it 'Integer array' do
        criterion = ->(num) { num.is_a? Integer }
        shared_block = proc { |num| criterion.call(num) }
        expected_output = num_array.all?(&shared_block)
        expect(num_array.my_all?(&shared_block)).to eq(expected_output)
      end

      it 'String array' do
        criterion = ->(str) { str.length > 2 }
        shared_block = proc { |str| criterion.call(str) }
        expected_output = str_array.all?(&shared_block)
        expect(str_array.my_all?(&shared_block)).to eq(expected_output)
      end

      it 'Hash' do
        criterion = ->(key, _val) { key.is_a? Symbol }
        shared_block = proc { |key, _val| criterion.call(key, _val) }
        expected_output = hash.all?(&shared_block)
        expect(hash.my_all?(&shared_block)).to eq(expected_output)
      end
    end

    context 'Edge cases:' do
      it 'Empty arrays return true' do
        select_criterion = ->(val) { val.nil? }
        expected_output = [].all? { |val| select_criterion.call(val) }
        expect([].my_all? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Empty hashes return true' do
        select_criterion = ->(_key, val) { val.nil? }
        expected_output = {}.all? { |key, val| select_criterion.call(key, val) }
        expect({}.my_all? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end

    context 'Nested structures:' do
      it 'Nested arrays' do
        select_criterion = ->(val) { val.length > 2 }
        expected_output = nested_array.all? { |val| select_criterion.call(val) }
        expect(nested_array.my_all? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Nested hashes' do
        select_criterion = ->(_key, val) { val.length > 2 }
        expected_output = nested_hash.all? { |key, val| select_criterion.call(key, val) }
        expect(nested_hash.my_all? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end
  end

  describe '5.#my_any? method' do
    context 'Example structures' do
      it 'Integer array' do
        criterion = ->(num) { num > 2 }
        shared_block = proc { |num| criterion.call(num) }
        expected_output = num_array.any?(&shared_block)
        expect(num_array.my_any?(&shared_block)).to eq(expected_output)
      end

      it 'String array' do
        criterion = ->(str) { str.length < 2 }
        shared_block = proc { |str| criterion.call(str) }
        expected_output = str_array.any?(&shared_block)
        expect(str_array.my_any?(&shared_block)).to eq(expected_output)
      end

      it 'Hash' do
        criterion = ->(key, _val) { key.is_a? String }
        shared_block = proc { |key, val| criterion.call(key, val) }
        expected_output = hash.any?(&shared_block)
        expect(hash.my_any?(&shared_block)).to eq(expected_output)
      end
    end

    context 'Edge cases:' do
      it 'Empty arrays return false' do
        select_criterion = ->(val) { val.nil? }
        expected_output = [].any? { |val| select_criterion.call(val) }
        expect([].my_any? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Empty hashes return false' do
        select_criterion = ->(_key, val) { val.nil? }
        expected_output = {}.any? { |key, val| select_criterion.call(key, val) }
        expect({}.my_any? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end

    context 'Nested structures:' do
      it 'Nested arrays' do
        select_criterion = ->(val) { val.length > 2 }
        expected_output = nested_array.any? { |val| select_criterion.call(val) }
        expect(nested_array.my_any? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Nested hashes' do
        select_criterion = ->(_key, val) { val.length > 2 }
        expected_output = nested_hash.any? { |key, val| select_criterion.call(key, val) }
        expect(nested_hash.my_any? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end
  end

  describe '5.#my_none? method' do
    context 'Example structures' do
      it 'Integer array' do
        criterion = ->(num) { num <= 2 }
        shared_block = proc { |num| criterion.call(num) }
        expected_output = num_array.none?(&shared_block)
        expect(num_array.my_none?(&shared_block)).to eq(expected_output)
      end

      it 'String array' do
        criterion = ->(str) { str.length < 2 }
        shared_block = proc { |str| criterion.call(str) }
        expected_output = str_array.none?(&shared_block)
        expect(str_array.my_none?(&shared_block)).to eq(expected_output)
      end

      it 'Hash' do
        criterion = ->(key, _val) { key.is_a? String }
        shared_block = proc { |key, val| criterion.call(key, val) }
        expected_output = hash.none?(&shared_block)
        expect(hash.my_none?(&shared_block)).to eq(expected_output)
      end
    end

    context 'Edge cases:' do
      it 'Empty arrays return true' do
        select_criterion = ->(val) { val.nil? }
        expected_output = [].none? { |val| select_criterion.call(val) }
        expect([].my_none? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Empty hashes return true' do
        select_criterion = ->(_key, val) { val.nil? }
        expected_output = {}.none? { |key, val| select_criterion.call(key, val) }
        expect({}.my_none? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end

    context 'Nested structures:' do
      it 'Nested arrays' do
        select_criterion = ->(val) { val.length > 2 }
        expected_output = nested_array.none? { |val| select_criterion.call(val) }
        expect(nested_array.my_none? { |val| select_criterion.call(val) }).to eq(expected_output)
      end

      it 'Nested hashes' do
        select_criterion = ->(_key, val) { val.length > 2 }
        expected_output = nested_hash.none? { |key, val| select_criterion.call(key, val) }
        expect(nested_hash.my_none? { |key, val| select_criterion.call(key, val) }).to eq(expected_output)
      end
    end
  end
end
