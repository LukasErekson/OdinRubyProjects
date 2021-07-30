# frozen_string_literal: true

# Player Class
class Player
  OFF_LIMIT_CHARACTERS = ['_', '[', ']', ' ', '\t', '\n'].freeze

  attr_accessor :marker, :name, :score

  def initialize(marker, name = 'Player')
    raise "#{marker} is off limits!" if OFF_LIMIT_CHARACTERS.include? marker

    @marker = marker
    @name = name
    @score = 0
  end

  def to_s
    name
  end
end
