# frozen_string_literal: true

# A part of the board
class BoardSlot
  attr_reader :is_free, :location
  attr_accessor :fill_char

  def initialize(location)
    @is_free = true
    @location = location
    @fill_char = '_'
  end

  def mark(marker)
    raise "#{location} is NOT available." unless @is_free

    @is_free = false
    @fill_char = marker
    nil
  end

  def clear_slot
    @fill_char = '_'
    @is_free = true
  end

  def to_s
    fill_char.to_s
  end
end
