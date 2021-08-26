# frozen_string_literal: true

require_relative 'occupied_slot_error'
require_relative 'value_error'
require_relative 'validate_marker'

##
# A slot in the Tic Tac Toe board. Contains a fill character,
# whether or not it's free, and its location.
class BoardSlot
  include ValidateMarker

  attr_reader :free, :location, :fill_char

  ##
  # Initialize an unoccupied slot and denote it with +_+.
  #
  # +location+::  The key corresponding to what its location is
  #               in the board.
  def initialize(location)
    @free = true
    @location = location
    @fill_char = '_'
  end

  ##
  # Marks the slot with +marker+ and returns true if unoccupied.
  # If the slot is occupied, it raises an OccupiedSlot Error.
  def mark(marker)
    raise OccupiedSlotError @location unless @free

    @free = false
    @fill_char = marker
    true
  end

  ##
  # Assigns +@fill_char+ if and only if it is a string of length 1.
  # Raises a +ValueError+ if the assumptions are not met.
  def fill_char=(other)
    valid?(other)

    @fill_char = other
  end

  ##
  # Clears the slot and makes it available again.
  def clear
    @fill_char = '_'
    @free = true
  end

  ##
  # Denotes the slot by its fill character.
  def to_s
    @fill_char
  end
end
