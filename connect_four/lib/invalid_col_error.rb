# frozen_string_literal: true

##
# Error class for handling column errors for Connect Four
class InvalidColumnError < StandardError
  ##
  # Display a specific message depending on the cause
  def initialize(col_number, cause, *args)
    case cause
    when 'full'
      super("Column #{col_number} you selected is full.", *args)
    when 'range'
      super("Column #{col_number} is not within the range (1-7)", *args)
    else
      super("Column #{col_number} casued by #{cause}", *args)
    end
  end
end
