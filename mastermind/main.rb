# frozen_string_literal: true

require_relative 'mastermind'

mastermind_game = Mastermind.new

loop do
  puts ''
  puts 'Welcome to Mastermind for Ruby!'
  puts 'Please select one of the following gamemodes:'
  puts '1. Codebreaker -- easy ["easy"]'
  puts '2. Codebreaker -- standard ["standard"]'
  puts '3. Codemaker [codemaker]'
  puts '4. Quit [q, quit, exit]'
  puts ''

  mastermind_game.new_game

  mastermind_game.print_score

  player_response = gets.chomp.downcase

  case player_response
  when '1', 'easy'
    mastermind_game.play_codebreaker('easy')
  when '2', 'standard'
    mastermind_game.play_codebreaker('standard')
  when '3', 'codemaker'
    mastermind_game.play_codemaker
  when '4', 'q', 'quit', 'exit'
    puts 'Thank you for playing! Have a nice day.'
    break
  else
    puts 'Please choose one of the options outlined above.'
  end
end
