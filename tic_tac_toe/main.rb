# frozen_string_literal: true

require_relative './lib/player'
require_relative './lib/board_slot'
require_relative './lib/tic_tac_toe'

tic_tac_toe = TicTacToe.new

user_input = ''

until %w[exit quit q no].include? user_input
  winner = tic_tac_toe.play_round
  break if winner == -1

  puts "#{winner} wins! Play again?"
  puts 'Yes: any key  No: exit, quit, or no'
  user_input = gets.chomp.downcase
end

puts 'Have a nice day!'
