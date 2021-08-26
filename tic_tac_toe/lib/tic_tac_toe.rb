# frozen_string_literal: true

require_relative 'occupied_slot_error'

# Tic Tac Toe game, complete with board, players, and win conditions.
class TicTacToe
  attr_reader :board, :players, :free_slots, :current_player_idx, :num_games_played

  # The different combinations necessary for winning.
  WINNING_LOCATIONS = [%w[A1 A2 A3], %w[A1 B1 C1],
                       %w[B1 B2 B3], %w[A2 B2 C2],
                       %w[C1 C2 C3], %w[A3 B3 C3],
                       %w[A1 B2 C3], %w[C1 B2 A3]].freeze

  ##
  # Initialize the board with a board hash with the different
  # locations as keys.
  def initialize
    @board = { 'A1' => BoardSlot.new('A1'), 'A2' => BoardSlot.new('A2'),
               'A3' => BoardSlot.new('A3'), 'B1' => BoardSlot.new('B1'),
               'B2' => BoardSlot.new('B2'), 'B3' => BoardSlot.new('B3'),
               'C1' => BoardSlot.new('C1'), 'C2' => BoardSlot.new('C2'),
               'C3' => BoardSlot.new('C3') }
    @players = [Player.new('X', 'Player 1'), Player.new('O', 'Player 2')]
    @free_slots = 9
    @current_player_idx = 1
    @num_games_played = 0
  end

  ##
  # Plays a round of the game. A "round" is a full game that goes
  # until either someone wins or all the slots are filled. Returns the winning player.
  # In the event of a draw, it loops again.
  def play_round
    print_board

    until won?
      begin
        new_turn
        location = gets.chomp

        # End the game if the player inputs it
        return -1 if %w[quit exit q].include?(location)

        next unless validate_location(location)
      rescue OccupiedSlotError
        puts "#{location} is already filled. Please choose another location."

        # Increment to let the same player try again.
        increment_player_idx
        retry
      ensure
        print_board
      end

      next unless @free_slots.zero? && !won?

      puts "Looks like it's a draw! Press enter to play again."
      clear_board
      next
    end

    # Reset the board at the end of the game
    clear_board

    # Increment the number of games played
    @num_games_played += 1

    # Increment score and return winning player
    @players[@current_player_idx].increment_score
    @players[@current_player_idx]
  end

  ##
  # Frees up all slots to reset the board.
  def clear_board
    @board.each { |_location, slot| slot.clear }
    @free_slots = 9
  end

  ##
  # Returns whether the current player has won with their
  # most recent move.
  def won?
    player_marker = @players[@current_player_idx].marker
    WINNING_LOCATIONS.each do |winning_triple|
      return true if winning_triple.map { |loc| @board[loc].fill_char == player_marker }.all?
    end
    false
  end

  ##
  # Increments the current player index
  def increment_player_idx
    @current_player_idx = (@current_player_idx + 1) % 2
  end

  protected

  ##
  # Increments and prints whose turn it is.
  def new_turn
    # Update whose turn it is
    increment_player_idx

    puts "It's #{@players[@current_player_idx].name}'s turn."\
              " (#{@players[@current_player_idx].marker}'s)"
  end

  ##
  # Marks the board with the current player's marker
  #
  # +location+:: Where to mark the board.
  def mark_board(location)
    board[location].mark(players[@current_player_idx].marker)
    @free_slots -= 1
  end

  ##
  # Returns whether the given location is a valid location or not.
  #
  # +location+::  The location to validate or test.
  def validate_location(location)
    if @board.keys.to_a.include?(location)
      mark_board(location)
    else
      puts "#{location} is not a valid location."
      # Increment to let the same player try again.
      increment_player_idx
      false
    end
  end

  ##
  # Prints the board as well as the player's name, marker, and score.
  def print_board
    puts "\t 1\t 2\t 3\t\t Scores:"
    puts "A\t[#{board['A1']}]\t[#{board['A2']}]\t[#{board['A3']}]\t " \
         "#{players[0]}"
    puts "B\t[#{board['B1']}]\t[#{board['B2']}]\t[#{board['B3']}]\t " \
         "#{players[1]}"
    puts "C\t[#{board['C1']}]\t[#{board['C2']}]\t[#{board['C3']}]"
  end
end
