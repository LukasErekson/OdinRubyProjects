# frozen_string_literal: true

require_relative 'mastermind'

loop do
  puts ''
  puts 'Welcome to Mastermind for Ruby!'
  puts 'Please select one of the following gamemodes:'
  puts '1. Codebreaker -- easy ["easy"]'
  puts '2. Codebreaker -- standard ["standard"]'
  puts '3. Codemaker [codemaker]'
  puts '4. Quit [q, quit, exit]'
  puts ''

  mastermind_game = Mastermind.new

  player_response = gets.chomp.downcase

  case player_response
  when '1', 'easy'
    mastermind_game.play_codebreaker('easy')
  when '2', 'standard'
    mastermind_game.play_codebreaker('standard')
  when '3', 'codemaker'
    puts 'Coming soon!'
  when '4', 'q', 'quit', 'exit'
    puts 'Thank you for playing! Have a nice day.'
    break
  else
    puts 'Please chooseone of the options outlined above.'
  end
end
