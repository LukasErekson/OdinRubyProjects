# frozen_string_literal: true

# Problem with proposed code for MasterMind.
class CodeError < RangeError
  def initialize(required_length = 4, valid_colors = %w[R O Y G B I V])
    super("A code sequence is a string of #{required_length} color "\
          "characters from the following list: #{valid_colors}.")
  end
end
