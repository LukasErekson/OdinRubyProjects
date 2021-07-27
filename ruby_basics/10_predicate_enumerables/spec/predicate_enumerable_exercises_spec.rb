require 'spec_helper'
require_relative '../exercises/predicate_enumerable_exercises'

RSpec.describe 'Predicate Enumerable Exercises' do

  describe 'coffee drink exercise' do

    it 'returns true when coffee is included' do
      drink_list = ["coffee", "water", "tea"]
      expect(coffee_drink?(drink_list)).to be true
    end
    
    # remove the 'x' from the line below to unskip the test
    it 'returns true when espresso is included' do
      drink_list = ["milk", "juice", "espresso"]
      expect(coffee_drink?(drink_list)).to be true
    end

    it 'returns false when coffee or espresso is not included' do
      drink_list = ["tea", "water", "milk"]
      expect(coffee_drink?(drink_list)).to be false
    end

    it 'returns false when the list is empty' do
      drink_list = []
      expect(coffee_drink?(drink_list)).to be false
    end
  end

  describe 'correct guess exercise' do

    it 'returns true when the list contains the answer' do
      guess_list = [2, 3, 4, 5]
      answer = 5
      expect(correct_guess?(guess_list, answer)).to be true
    end

    it 'returns false when the list does not contain the answer' do
      guess_list = [6, 7, 8, 9]
      answer = 5
      expect(correct_guess?(guess_list, answer)).to be false
    end

    it 'returns false when the list is empty' do
      guess_list = []
      answer = 5
      expect(correct_guess?(guess_list, answer)).to be false
    end
  end

  describe 'recent years exercise' do

    it 'returns true when all of the years are between 2011 and 2021' do
      year_list = [2011, 2021, 2016]
      expect(recent_years?(year_list)).to be true
    end

    it 'returns false when one year is not between 2011 and 2021' do
      year_list = [2018, 2001, 2014]
      expect(recent_years?(year_list)).to be false
    end

    it 'returns true when the list is empty' do
      word_list = []
      expect(recent_years?(word_list)).to be true
    end
  end

  describe 'correct format exercise' do

    it 'returns true when none of the words in the list are in upcase' do
      word_list = ["Pepsi", "Coke", "Dr. Pepper"]
      expect(correct_format?(word_list)).to be true
    end

    it 'returns false when at least one word in the list is in upcase' do
      word_list = ["PEPSI", "Coke", "Dr. Pepper"]
      expect(correct_format?(word_list)).to be false
    end

    it 'returns true when the list is empty' do
      word_list = []
      expect(correct_format?(word_list)).to be true
    end
  end

  describe 'valid scores exercise' do

    it 'returns true when only one score is a 10' do
      score_list = { easy_to_read: 10, uses_best_practices: 8, clever: 7 }
      perfect_score = 10
      expect(valid_scores?(score_list, perfect_score)).to be true
    end

    it 'returns false when more than one score is a 10' do
      score_list = { easy_to_read: 10, uses_best_practices: 10, clever: 9 }
      perfect_score = 10
      expect(valid_scores?(score_list, perfect_score)).to be false
    end

    it 'returns false when the list is empty' do
      score_list = {}
      perfect_score = 10
      expect(valid_scores?(score_list, perfect_score)).to be false
    end
  end
end
