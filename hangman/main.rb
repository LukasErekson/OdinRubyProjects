# frozen_string_literal: true

require_relative './lib/game_display'

##
# Print the valid options for the main menu.
def print_options
  puts '1. Start a new game [new]'
  puts '2. Load a saved game [load]'
  puts '3. Quit the game [quit]'
end

display = GameDisplay.new

puts 'Welcome to Ruby Hangman! What would you like to do?'
loop do
  puts ''
  puts 'Please choose one of the options below:'
  print_options
  player_response = gets.chomp.downcase
  case player_response
  when '1' || 'new'
    display.play_current_game
    next
  when '2' || 'load'
    display.load_game
    display.play_current_game
    next
  when '3' || 'quit' || 'exit'
    puts 'Have a nice day!'
    break
  else
    raise StandardError('Invalid option!')
  end
rescue StandardError
  retry
end
