# frozen_string_literal: true

require_relative './player'
require_relative './game_board'
require_relative './invalid_col_error'

##
# Connect Four to play in the terminal
class ConnectFour
  attr_reader :player1, :player2

  ##
  # Initialize the gameboard and players
  def initialize(player1_name = 'Player 1', player2_name = 'Player 2')
    @player1 = Player.new(player1_name, Player::DEFAULT_TOKENS[0])
    @player2 = Player.new(player2_name, Player::DEFAULT_TOKENS[1])
    @game_board = GameBoard.new(@player1, @player2)
  end

  ##
  # Main gameplay loop
  def play
    puts @game_board
    quit_game = false
    loop do
      current_player = @game_board.players[@game_board.current_player_index]

      puts "Next up: #{current_player}"
      puts 'Select a slot to put you piece in.'
      slot_num = @game_board.get_player_input
      if slot_num == 'quit'
        quit_game = true
        break
      end

      begin
        @game_board.fill_slot(slot_num)
        puts @game_board

        if @game_board.won?
          current_player.increment_score
          puts "#{current_player.name} wins!"
          puts @player1
          puts @player2
          break
        elsif @game_board.available_slots.zero?
          puts "Looks like it's a tie!"
          break
        end
      rescue InvalidColumnError => e
        puts e
        next
      end
      @game_board.increment_turn
    end

    quit_game
  end
end
