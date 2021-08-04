# frozen_string_literal: true

require 'colorize'
require_relative 'code-error'
require_relative 'code'
require_relative 'simple-ai'

# Mastermind game class
class Mastermind
  NUM_TURNS_EASY = 6
  NUM_TURNS_HARD = 12
  attr_accessor :player_score, :computer_score

  # Set @turn and @won class variables.
  def initialize
    new_game
    @player_score = 0
    @computer_score = 0
  end

  # Reset game variables @turn and @won.
  def new_game
    @turn = 1
    @won = false
  end

  # Play Mastermind as the codebreaker.
  # @param [String] difficulty  What difficuly of the game.
  #
  # @return [nil]               Ends the game with a message based on outcome.
  def play_codebreaker(difficulty = 'hard')
    difficulty == 'easy' ? print_codebreaker_intro_easy : print_codebreaker_intro_hard
    @mastermind_code = Code.new
    num_turns = difficulty == 'easy' ? NUM_TURNS_EASY : NUM_TURNS_HARD
    num_turns.times do
      @computer_score += 1
      break if @won

      play_turn(difficulty)
    end
    end_game_codebreaker
  end

  # Play Mastermind as the codemaker with the computer guessing.
  def play_codemaker
    @mastermind_code = get_player_code
    # Set up the player to win if the loop terminates wihtout a
    # correct guess.
    @win = true
    # Start out with a recommended guess
    @computer_ai = SimpleAI.new('RROO')
    NUM_TURNS_HARD.times do
      @player_score += 1
      sleep(0.5) # Add time to make it more suspenseful
      if computer_play_turn
        @win = false
        break
      end
    end
    end_game_codemaker
  end

  # Print the player's and the computer's scores.
  def print_score
    puts "Player Score: #{@player_score}\tComputer Score: #{@computer_score}"
  end

  protected

  # Ask for a valid code from the player.
  #
  # @return [Code] player_code A valid code given by the player.
  def get_player_code
    puts 'Codemaker, please put in a valid code:'
    puts "The valid letters/colors are #{'R'.red}, #{'O'.light_red}, #{'Y'.yellow}, #{'G'.green}, #{'B'.blue}, #{'I'.light_blue}, and #{'V'.magenta}."
    puts 'Your code should be 4 characters long.'
    begin
      player_code = gets.chomp
      player_code = Code.new(player_code.upcase)
    rescue StandardError => e
      puts e
      retry
    end
    player_code
  end

  # Has the computer guess a round of what the code should be.
  # This implements an algorithm by Donald Knuth, which can be found
  # on wikipedia: https://en.wikipedia.org/wiki/Mastermind_(board_game)#Worst_case:_Five-guess_algorithm
  # @return [Boolean] Whether the computer guessed correctly or not.
  def computer_play_turn
    puts "Turn #{@turn}:"
    guess_result = @computer_ai.guess.compare_codes_standard(@mastermind_code)
    puts "Computer's Guess \t Feedback"
    puts "#{@computer_ai.guess} \t #{guess_result}"
    return true if guess_result.count('√') == 4

    # It was incorrect so eliminate codes as per the algorithm.
    @computer_ai.eliminate_codes(guess_result)
    @turn += 1
    false
  end

  # Play a turn of mastermind as the codebreaker.
  # @param [String] difficulty  What difficuly of the game.
  #
  # @return [guess_code]         The code corresponding to the player's guess.
  def play_turn(difficulty)
    guessed_code = player_guess
    guess_result = nil
    if difficulty == 'easy'
      guess_result = guessed_code.compare_codes_easy(@mastermind_code)
      puts guess_result
    else
      guess_result = guessed_code.compare_codes_standard(@mastermind_code)
      puts "Your Guess: \t Feedback"
      puts "#{guessed_code} \t #{guess_result}"
    end
    @turn += 1
    @won = true if guess_result.count('√') == 4
  end

  # Let the player guess and validate their guess is a proper code.
  def player_guess
    puts "Turn #{@turn} - Put your guess in below:"
    begin
      guess = gets.chomp
      guess_code = Code.new(guess.upcase)
    rescue StandardError => e
      puts e
      retry
    end
    guess_code
  end

  # Prints the instructions for the easy game.
  def print_codebreaker_intro_easy
    puts 'Welcome to Mastermind! You are playing the role of the codebreaker.'
    puts 'The computer will choose a 4-color code that you will try to guess.'
    puts "The valid letters/colors are #{'R'.red}, #{'O'.light_red}, #{'Y'.yellow}, #{'G'.green}, #{'B'.blue}, #{'I'.light_blue}, and #{'V'.magenta}."
    puts ''
    puts 'You will get feedback from the code master after each round in the locations corresponding to your guess.'
    puts 'A "√" means you have the right color in the right place.'
    puts 'An "X" means that the color is in the code but not in that place.'
    puts 'Finally, a "." means that color is not part of the code.'
    puts 'You have 6 rounds to guess correctly. Good luck!'
    puts ''
  end

  # Prints the instructions for the hard (standard) game.
  def print_codebreaker_intro_hard
    puts 'Welcome to Mastermind! You are playing the role of the codebreaker.'
    puts 'The computer will choose a 4-color code that you will try to guess.'
    puts "The valid letters/colors are #{'R'.red}, #{'O'.light_red}, #{'Y'.yellow}, #{'G'.green}, #{'B'.blue}, #{'I'.light_blue}, and #{'V'.magenta}."
    puts 'You will get feedback from the code master after each round.'
    puts 'The location of the feedback is random and does not necessarily correspond to locations in your guess.'
    puts 'A "√" indicates that the right color in the right place somewhere.'
    puts 'An "X" indicates there is a color that is in the code but not in the right place.'
    puts 'Finally, a "." indicates a color is not part of the code.'
    puts 'You have 12 rounds to guess correctly. Good luck!'
    puts ''
  end

  # Ends the game whether the player won or lost as the codebreaker
  def end_game_codebreaker
    if @won
      puts 'Congratulations! You win!'
    else
      puts "Better luck next time! The code was #{@mastermind_code}."
      @computer_score += 1
    end
    # Give some time for the player's response
    sleep(1)
  end

  # Ends the game whether the player won or lost as the codemaker.
  def end_game_codemaker
    if @won
      puts 'Congratulations! You chose a really difficult code!'
      @player_score += 1
    else
      puts 'Better luck next time!'
      puts "The computer was able to guess #{@mastermind_code} in #{@turn} turn#{@turn == 1 ? '' : 's'}."
    end
    # Give some time for the player's response
    sleep(1)
  end
end
