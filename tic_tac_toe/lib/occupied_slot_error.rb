# frozen_string_literal: true

##
# Occupied slot error. Meant to be raised if there is an
# attempt to fill a non-open slot.
class OccupiedSlotError < StandardError
  ##
  # Initialize a StandardError with an occupied space message.
  #
  # +location+:: The location that is occupied.
  def initialize(location)
    super("#{location} is already occupied.")
  end
end
