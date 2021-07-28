require 'spec_helper'
require_relative '../bubble_sort.rb'

RSpec.describe 'Bubble Sort Project Specifications' do
  describe 'The Odin Project example' do
      
      it 'works with the Odin Project example' do
        expected_output = [0, 2, 2, 3, 4, 78]
        expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eq(expected_output)
      end

  end

  describe 'swap method tests' do
      array = [1, 2, 3, 4]

      it 'successfully swaps two elements at given indices' do
        swap(array, 0, 1)
        expect(array).to eq([2, 1, 3, 4])
      end

      it 'successfully swaps two elements back' do
        swap(array, 0, 1)
        expect(array).to eq([1, 2, 3, 4])
      end

  end

  describe 'Personal test case' do

      context 'integer tests' do

        it 'sorts in the "worst-case scenario"'  do
          expected_output = [1, 2, 3, 4, 5]
          expect(bubble_sort([5, 4, 3, 2, 1])).to eq(expected_output)
        end

        it 'sorts with negative values' do
          expected_output = [-1, 0, 1, 1000]
          expect(bubble_sort([-1, 0, 1, 1000])).to eq(expected_output)
        end

        it 'doesn\'t unsort a sorted array' do
          expected_output = [1, 2, 3]
          expect(bubble_sort([1, 2, 3])).to eq(expected_output)
        end

      end

      context 'arrays of other data types' do
        
        it 'works with strings' do
          expected_output = ['a', 'b', 'c']
          expect(bubble_sort(['c', 'a', 'b'])).to eq(expected_output)
        end

        it 'returns empty array if given an empty array' do
          expected_output = []
          expect(bubble_sort([])).to eq([])
        end

      end

  end

end

