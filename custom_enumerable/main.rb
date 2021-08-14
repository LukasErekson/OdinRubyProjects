# frozen_string_literal: true

require_relative 'my_enumerable'

def multiply_els(array)
  array.my_inject { |accumulator, value| accumulator * value }
end

puts multiply_els([2, 4, 5])
