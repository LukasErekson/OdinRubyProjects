# frozen_string_literal: true

require_relative 'code_error'
require_relative 'code'

# Mastermind game class
class Mastermind
  NUM_TURNS = 12

  def initialize
    @guesser_moves = []
    @coder_responses = []
    @turn = 1
    @won = false
  end

  def play_guesser
    print_guesser_intro
    @mastermind_code = Code.new
    NUM_TURNS.times do
      break if @won

      play_turn
    end
    end_game
  end

  def play_turn
    guess_result = player_guess.compare_codes(@mastermind_code)
    puts guess_result
    @won = true if guess_result == '√√√√'
    @turn += 1
  end

  protected

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

  def print_guesser_intro
    puts 'Welcome to Mastermind! You are playing the role of the guesser.'
    puts 'The computer will choose a 4-color code that you will try to guess.'
    puts 'The valid letters/colors are R, O, Y, G, B, I, V.'
    puts ''
    puts 'You will get feedback from the code master after each round.'
    puts 'A "√" means you have the right color in the right place.'
    puts 'An "X" means that the color is in the code but not in that place.'
    puts 'Finally, a "." means that color is not part of the code.'
    puts 'You have 12 rounds to guess correctly. Good luck!'
    puts ''
  end

  def end_game
    if @won
      puts 'Congratulations! You win!'
    else
      puts "Better luck next time! The code was #{@mastermind_code}."
    end
  end
end
