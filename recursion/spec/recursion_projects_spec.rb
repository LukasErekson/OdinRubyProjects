# frozen_string_literal: true

require_relative '../recursion'
require_relative 'spec_helper'
require 'rspec'

RSpec.describe 'Recursion Project Tests:' do
  describe 'Iterative Fibonacci' do
    context 'Simple examples' do
      it ' - fibs(5) = 5' do
        expect(fibs(5)).to eq(5)
      end

      it ' - fibs(6) = 8' do
        expect(fibs(6)).to eq(8)
      end
    end

    context 'Edge cases' do
      it ' - fibs(0) = 0' do
        expect(fibs(0)).to eq(0)
      end

      it ' - fibs(1) = 1' do
        expect(fibs(1)).to eq(1)
      end

      it ' - fibs(-1) = 0' do
        expect(fibs(-1)).to eq(0)
      end
    end
  end

  describe 'Recursive Fibonacci' do
    context 'Simple examples' do
      it ' - fibs(5) = 5' do
        expect(fibs_rec(5)).to eq(5)
      end

      it ' - fibs(6) = 8' do
        expect(fibs_rec(6)).to eq(8)
      end
    end

    context 'Edge cases' do
      it ' - fibs(0) = 0' do
        expect(fibs_rec(0)).to eq(0)
      end

      it ' - fibs(1) = 1' do
        expect(fibs_rec(1)).to eq(1)
      end

      it ' - fibs(-1) = 0' do
        expect(fibs_rec(-1)).to eq(0)
      end
    end
  end

  describe 'Merge sorted arrays' do
    it ' - sort arrays of the same size' do
      expect(merge_sorted_arrays([1, 2], [3, 4])).to eq([1, 2, 3, 4])
    end

    it ' - sort arrays of different sizes' do
      expect(merge_sorted_arrays([1], [2, 4])).to eq ([1, 2, 4])
    end

    it ' - sort arrays where all values of arr2 are less than arr1' do
      expect(merge_sorted_arrays([4, 5], [0, 1])).to eq([0, 1, 4, 5])
    end
  end

  describe 'Merge sort' do
    context 'Simple examples' do
      it ' - sorts sorted arrays' do
        expect(mergesort([1, 2, 3, 4, 5])).to eq([1, 2, 3, 4, 5])
      end

      it ' - sorts worst-case sorted arrays' do
        expect(mergesort([5, 4, 3, 2, 1, 0])).to eq((0..5).to_a)
      end
    end

    context 'Edge cases' do
      it ' - empty array returns an empty array' do
        expect(mergesort([])).to eq([])
      end
    end

    context 'Random arrays' do
      it ' - small random array (10 elements)' do
        random_array = Array.new(10) { rand 1000 }
        expect(mergesort(random_array)).to eq(random_array.sort)
      end

      it ' - large random array (10,000 elements)' do
        random_array = Array.new(10_000) { rand 1000 }
        expect(mergesort(random_array)).to eq(random_array.sort)
      end
    end
  end
end
