# frozen_string_literal: true

##
# Player object for Connect Four.
#
# +name+::  The player's name or unqiue string ID
# +token+:: The symbol that represents a player's move
# +score+:: How many games this player has won
class Player
  attr_reader :name, :token, :score

  DEFAULT_TOKENS = %w[⚪, ⚫].freeze

  ##
  # Initialize instance variables.
  def initialize(name = 'Player', token = '⚪')
    raise StandardError('Name must be a string object') unless name.is_a? String
    raise StandardError('Token must be a string object') unless token.is_a? String
    raise StandardError('Token cannot be "O"') if token == 'O'

    @name = name
    @token = token
    @score = 0
  end

  ##
  # Increment the score by one. This should only be done when
  # the palyer has won a game.
  def increment_score
    @score += 1
  end

  ##
  # Returns the palyer's name, token, and score in a string
  def to_s
    "#{@name} (#{@token}): #{@score}"
  end
end
