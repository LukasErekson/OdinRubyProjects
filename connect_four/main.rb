# frozen_string_literal: true

require_relative './lib/connect_four'
require 'yaml'

game = ConnectFour.new

player_input = ''

until %w[quit exit q no].include?(player_input)
  result = game.play
  break if result

  puts 'Press anything to play again or exit, quit, or q to leave.'

  begin
    player_input = gets.to_s.chomp.downcase
  rescue StandardError
    puts 'Please put valid input (quit, exit, or q)'
    retry
  end

end

puts 'Have a nice day!'
