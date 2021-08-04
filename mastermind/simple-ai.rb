# frozen_string_literal: true

require_relative 'code'

# A simple Mastermind AI
class SimpleAI
  ALLOWED_PEG_VALS = %w[R O Y G B I V].freeze
  CODE_LENGTH = 4
  attr_reader :guess, :possible_codes

  # Populate and initialize the possible codes array and initial guess.
  def initialize(initial_guess)
    @guess = Code.new(initial_guess)
    @possible_codes = ALLOWED_PEG_VALS.repeated_permutation(CODE_LENGTH).to_a
  end

  # Eliminate all the values that are eliminated by the given response.
  # Uses the algorithm by Donald Knuth and as explained in Grant Husbandss's answer
  # at https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind
  #
  # @param [String] feedback  The feedback given from the previous guess.
  def eliminate_codes(feedback)
    @possible_codes = @possible_codes.select do |code_arr|
      code_str = code_arr.reduce(:+)
      guess_feedback = @guess.compare_codes_standard(Code.new(code_str))
      guess_feedback.count('√') == feedback.count('√') && \
        guess_feedback.count('X') == feedback.count('X') && \
        guess_feedback.count('.') == feedback.count('.')
    end
    # Return the next guess
    next_guess_str = @possible_codes[0].reduce(:+)
    @guess = Code.new(next_guess_str)
  end
end
