# frozen_string_literal: true

require_relative 'player'
require_relative 'invalid_col_error'

##
# Gameboard object for Connect Four
class GameBoard
  attr_reader :players, :current_player_index

  ##
  # Initialize board using a nested array, create player list,
  # and start turn order.
  def initialize(player1 = Player.new('Player 1', Player::DEFAULT_TOKENS[0]),
                 player2 = Player.new('Player 2', Player::DEFAULT_TOKENS[1]))
    raise StandardError, 'Each players token must be unique.' if player1.token == player2.token

    @players = [player1, player2]
    raise StandardError, 'Parameters must be player objects.' unless @players.all? { |arg| arg.is_a? Player }

    @current_player_index = 0
    # Board where spaces are accessed by board[column][row] with
    # column 0 being the furthest left and row 0 being the bottom.
    @board = Array.new(7) { Array.new(6) { 'O' } }
  end

  ##
  # Increments whose turn it is and returns @current_player_index
  def increment_turn
    @current_player_index = (@current_player_index + 1) % 2
  end

  ##
  # Fills the slot with the next available spot
  def fill_slot(column)
    raise InvalidColumnError(column.to_s, 'range') unless column.between?(0, 6)

    row = available_row(column)
    raise InvalidColumnError(coulmn.to_s, 'full') if row.nil?

    @board[column][row] = @players[@current_player_index].token
  end

  ##
  # Prints out the game board with player tokens in the places
  # they've played and empty slots as O
  def to_s
    board_string = "=================\n"
    (0..5).reverse_each do |row|
      board_string += '| '
      (0..6).each do |column|
        board_string += "#{@board[column][row]} "
      end
      board_string += "|\n"
    end
    board_string += "=================\n"
    board_string += "  1 2 3 4 5 6 7\n"

    board_string
  end

  protected

  ##
  # Finds the next available index in a given column
  def available_row(column)
    @board[column].index('O')
  end
end
