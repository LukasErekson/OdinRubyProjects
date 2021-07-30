# frozen_string_literal: true

require_relative 'player'
require_relative 'board_slot'
require_relative 'tic_tac_toe'

tic_tac_toe = TicTacToe.new

user_input = ''

until %w[exit quit q no].include? user_input
  winner = tic_tac_toe.play_round
  break if winner == -1

  puts "#{winner} wins! Play again?"
  user_input = gets.chomp
end

puts 'Have a nice day!'
