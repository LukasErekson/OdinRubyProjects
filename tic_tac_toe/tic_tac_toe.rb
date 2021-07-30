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

# The game board
class GameBoard
  attr_reader :board, :players, :free_slots

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
  end

  def mark_board(current_player_idx, location)
    board[location].mark(players[current_player_idx].marker)
    @free_slots -= 1
  end

  def print_board
    puts "\t 1\t 2\t 3\t\t Scores:"
    puts "A\t[#{board['A1']}]\t[#{board['A2']}]\t[#{board['A3']}]\t " \
         "#{players[0].name} (#{players[0].marker}): #{players[0].score}"
    puts "B\t[#{board['B1']}]\t[#{board['B2']}]\t[#{board['B3']}]\t " \
         "#{players[1].name} (#{players[1].marker}): #{players[1].score}"
    puts "C\t[#{board['C1']}]\t[#{board['C2']}]\t[#{board['C3']}]"
  end

  def clear_board
    @board.each { |_location, slot| slot.clear_slot }
    @free_slots = 9
  end

  def won?(current_player_idx)
    victory_mark = @players[current_player_idx].marker
    WINNING_LOCATIONS.each do |winning_triple|
      if winning_triple.map { |loc| @board[loc].fill_char == victory_mark }.all?
        @players[current_player_idx].score += 1
        return true
      end
    end

    false
  end
end

# Start the game loop
def play_round(game_board)
  current_player_idx = 1
  game_board.print_board

  until game_board.won? current_player_idx
    begin
      current_player_idx = (current_player_idx + 1) % 2
      puts "It's #{game_board.players[current_player_idx]}'s turn.
            (#{game_board.players[current_player_idx].marker}'s')"
      location = gets.chomp
      if game_board.board.keys.to_a.include?(location)
        game_board.mark_board(current_player_idx, location)
      elsif %w[quit exit].include?(location)
        return -1
      else
        puts "#{location} is not a valid location."
        # Increment to let the same player try again.
        current_player_idx = (current_player_idx + 1) % 2
        next
      end
    rescue StandardError
      puts "#{location} is already filled. Please choose another location."
      # Increment to let the same player try again.
      current_player_idx = (current_player_idx + 1) % 2
      retry
    ensure
      game_board.print_board
    end

    next unless game_board.free_slots.zero?

    puts "Looks like it's a draw! Press enter to play again."
    game_board.clear_board
    gets

  end

  # Clear for next game
  game_board.clear_board

  # Return the victor
  current_player_idx
end

game_board = GameBoard.new

user_input = ''

unless %w[exit quit q no].include?(user_input)
  winner_idx = play_round(game_board)
  puts "Player #{winner_idx + 1} wins! Play again?" unless winner_idx == -1
  user_input = gets.chomp
end

puts 'Have a nice day!'
