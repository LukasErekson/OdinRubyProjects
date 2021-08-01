# frozen_string_literal: true

require_relative 'code_error'

# Code object for the game 'Mastermind'
class Code
  ALLOWED_PEG_VALS = %w[R O Y G B I V].freeze
  CODE_LENGTH = 4
  attr_reader :code_sequence

  # Validate code_sequence
  def initialize(code_sequence = nil)
    if code_sequence.nil?
      @code_sequence = set_random_code
    elsif (code_sequence.instance_of? String) && (code_sequence.length == CODE_LENGTH)
      @code_sequence = []
      code_sequence.split('').each do |letter|
        if ALLOWED_PEG_VALS.include?(letter)
          @code_sequence.push(letter)
        else
          raise CodeError.new(CODE_LENGTH, ALLOWED_PEG_VALS)
        end
      end
    else
      raise CodeError.new(CODE_LENGTH, ALLOWED_PEG_VALS)
    end
  end

  # Create random (valid) code
  def set_random_code
    # Sample CODE_LENGTH times to allow for repitition rather than
    # ALLOWED_PEG_VALS.sample(CODE_LENGTH), which doesn't allow repitition.
    (1..CODE_LENGTH).map { ALLOWED_PEG_VALS.sample }
  end

  # Compare two codes returning a string of the difference
  def compare_codes(other_code)
    raise TypeError("Other code must be of Code type, not #{other_code.class}.") unless other_code.instance_of?(Code)

    code_difference = ''
    @code_sequence.each_with_index do |letter, index|
      puts letter
      puts index
      puts other_code.code_sequence.include?(letter)
      code_difference += if other_code.code_sequence.include?(letter)
                           if other_code.code_sequence[index] == letter
                             '√'
                           else
                             'X'
                           end
                         else
                           '.'
                         end
    end
    code_difference
  end

  def to_s
    @code_sequence.reduce(:+)
  end
end
