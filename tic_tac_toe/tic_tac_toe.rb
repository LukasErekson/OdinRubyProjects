# frozen_string_literal: true

# Tic Tac Toe game, complete with board, players, and win conditions.
class TicTacToe
  attr_reader :board, :players, :free_slots, :current_player_idx, :num_games_played

  @num_games_played = 0

  WINNING_LOCATIONS = [%w[A1 A2 A3], %w[A1 B1 C1],
                       %w[B1 B2 B3], %w[A2 B2 C2],
                       %w[C1 C2 C3], %w[A3 B3 C3],
                       %w[A1 B2 C3], %w[C1 B2 A3]].freeze

  def initialize
    @board = { 'A1' => BoardSlot.new('A1'), 'A2' => BoardSlot.new('A2'),
               'A3' => BoardSlot.new('A3'), 'B1' => BoardSlot.new('B1'),
               'B2' => BoardSlot.new('B2'), 'B3' => BoardSlot.new('B3'),
               'C1' => BoardSlot.new('C1'), 'C2' => BoardSlot.new('C2'),
               'C3' => BoardSlot.new('C3') }
    @players = [Player.new('X', 'Player 1'), Player.new('O', 'Player 2')]
    @free_slots = 9
    @current_player_idx = 1
  end

  def print_board
    puts "\t 1\t 2\t 3\t\t Scores:"
    puts "A\t[#{board['A1']}]\t[#{board['A2']}]\t[#{board['A3']}]\t " \
         "#{players[0].name} (#{players[0].marker}): #{players[0].score}"
    puts "B\t[#{board['B1']}]\t[#{board['B2']}]\t[#{board['B3']}]\t " \
         "#{players[1].name} (#{players[1].marker}): #{players[1].score}"
    puts "C\t[#{board['C1']}]\t[#{board['C2']}]\t[#{board['C3']}]"
  end

  # Start the game loop
  def play_round
    print_board

    until won?
      begin
        location = turn

        if @board.keys.to_a.include?(location)
          mark_board(@current_player_idx, location)
        elsif %w[quit exit].include?(location)
          return -1
        else
          puts "#{location} is not a valid location."
          # Increment to let the same player try again.
          @current_player_idx = (@current_player_idx + 1) % 2
          next
        end
      rescue StandardError
        puts "#{location} is already filled. Please choose another location."
        # Increment to let the same player try again.
        @current_player_idx = (@current_player_idx + 1) % 2
        retry
      ensure
        print_board
      end

      next unless @free_slots.zero? && !won?

      puts "Looks like it's a draw! Press enter to play again."
      clear_board
      gets
    end

    # Reset the board at the end of the game
    clear_board

    # Increment score and return winning player
    @players[@current_player_idx].score += 1
    @players[@current_player_idx]
  end

  protected

  def mark_board(current_player_idx, location)
    board[location].mark(players[current_player_idx].marker)
    @free_slots -= 1
  end

  def clear_board
    @board.each { |_location, slot| slot.clear_slot }
    @free_slots = 9
  end

  def won?
    player_marker = @players[@current_player_idx].marker
    WINNING_LOCATIONS.each do |winning_triple|
      return true if winning_triple.map { |loc| @board[loc].fill_char == player_marker }.all?
    end
    # Return false for no winners
    false
  end

  def turn
    # Update whose turn it is
    @current_player_idx = (@current_player_idx + 1) % 2

    puts "It's #{@players[@current_player_idx]}'s turn.
              (#{@players[@current_player_idx].marker}'s')"

    gets.chomp
  end
end
