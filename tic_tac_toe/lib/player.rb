# frozen_string_literal: true

require_relative 'validate_marker'

# Player Class for Tic Tac Toe, containing a name, marker, and score.
class Player
  include ValidateMarker

  attr_accessor :name
  attr_reader :marker, :score

  ##
  # Initialze a new Player with the given marker and name. Sets
  # initial score to 0.
  #
  # === Raises
  # Raises a ValueError if the marker is off limits.
  def initialize(marker, name = 'Player')
    valid?(marker)

    @marker = marker
    @name = name
    @score = 0
  end

  ##
  # Increment the player's score by 1.
  def increment_score
    @score += 1
  end

  ##
  # Display the player's name, marker, and score.
  def to_s
    "#{@name} (#{@marker}): #{@score}"
  end
end
