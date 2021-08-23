# frozen_string_literal: true

require_relative './lib/tree'

# The Odin Project simple driver script.

my_tree = Tree.new(Array.new(15) { rand(1..100) })
puts "The first tree is balanced: #{my_tree.balanced?}"

puts my_tree

puts "Level Order: #{my_tree.level_order}"

puts "Preorder: #{my_tree.preorder}"

puts "Inorder: #{my_tree.inorder}"

puts "Postorder: #{my_tree.postorder}"

puts 'Adding more elements to unbalance it'

15.times do
  my_tree.insert(rand(101..1000))
end

puts my_tree

puts "The new tree is balanced: #{my_tree.balanced?}"

puts 'Call rebalance'

my_tree.rebalance!

puts my_tree

puts "The new tree is balanced: #{my_tree.balanced?}"

puts my_tree

puts "Level Order: #{my_tree.level_order}"

puts "Preorder: #{my_tree.preorder}"

puts "Inorder: #{my_tree.inorder}"

puts "Postorder: #{my_tree.postorder}"
