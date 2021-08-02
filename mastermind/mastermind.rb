# frozen_string_literal: true

require 'colorize'
require_relative 'code_error'
require_relative 'code'

# Mastermind game class
class Mastermind
  NUM_TURNS_EASY = 6
  NUM_TURNS_HARD = 12

  # Set @turn and @won class variables.
  def initialize
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
      break if @won

      play_turn(difficulty)
    end
    end_game
  end

  protected

  # Play a turn of mastermind as the codebreaker.
  # @param [String] difficulty  What difficuly of the game.
  #
  # @return [guess_code]         The code corresponding to the player's guess.
  def play_turn(difficulty)
    guessed_code = player_guess
    guess_result = guessed_code.compare_codes(@mastermind_code)
    if difficulty == 'easy'
      puts guess_result
    else
      puts "Your Guess: \t Feedback"
      puts "#{guessed_code} \t #{guess_result.split('').shuffle.reduce(:+)}"
    end
    @won = true if guess_result == '√√√√'
    @turn += 1
  end

  # Let the player guess and validate their guess is a proper code.
  def player_guess
    puts "Turn #{@turn} - Put your guess in below:"
    begin
      guess = gets.chomp
      guess_code = Code.new(guess)
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
    puts 'The location of the feedback is random and does not necessarily correspond to your guess.'
    puts 'A "√" indicates that the right color in the right place somewhere.'
    puts 'An "X" indicates there is a color that is in the code but not in the right place.'
    puts 'Finally, a "." indicates a color is not part of the code.'
    puts 'You have 12 rounds to guess correctly. Good luck!'
    puts ''
  end

  # Ends the game whether the player won or lost.
  def end_game
    if @won
      puts 'Congratulations! You win!'
    else
      puts "Better luck next time! The code was #{@mastermind_code}."
    end
  end
end
