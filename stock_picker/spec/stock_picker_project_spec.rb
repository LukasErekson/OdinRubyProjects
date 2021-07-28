require 'spec_helper'
require_relative '../stock_picker.rb'

RSpec.describe 'Stock Picker Project Specifications' do
    describe 'The Odin Project example' do
        
        it 'works with one word in the first argument' do
            expected_output = [1, 4]
            expect(stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])).to eq(expected_output)
        end

    end

    describe 'Personal test case' do

        context 'algorithm test' do

            it 'works when the cheapest price is first (1/2)' do
                expected_output = [0, 4]
                expect(stock_picker([1, 2, 3, 4, 1000])).to eq(expected_output)
            end

            it 'works when the cheaepest price is first (2/2)' do
                expected_output = [0, 2]
                expect(stock_picker([10, 100, 1000])).to eq(expected_output)
            end

            it 'works when the cheapest price is last' do
                expected_output = [1, 3]
                expect(stock_picker([1000, 2, 3, 4, 1])).to eq(expected_output)
            end

        end

        context 'argument validation test' do

            it 'returns empty array if given an empty array' do
                expected_output = []
                expect(stock_picker([])).to eq(expected_output)
            end

            it 'returns empty array if given array with only one element' do
                expected_output = []
                expect(stock_picker([1])).to eq(expected_output)
            end

            it 'raises a TypeError if given something other than an array' do
               expect{ stock_picker(3) }.to raise_error(TypeError) 
            end

        end

    end

end