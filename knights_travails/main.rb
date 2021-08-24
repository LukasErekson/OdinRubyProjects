# frozen_string_literal: true

# The 8 changes in x and y positions valid for a knight's move.
KNIGHT_MOVES_DELTA = [1, -1, 2, -2].permutation(2).reject { |n| n.sum.zero? }

##
# Prints the shortest path a knight takes from +initial_space+ to +target_space+.
#
# +initial_space+::   The starting space of the knight.
# +target_space+::    The desired end space goal.
def knight_moves(initial_space, target_space)
  path = find_knight_path(initial_space, target_space)

  puts "You got from #{initial_space} to #{target_space} in #{path.length - 1} moves!"

  puts 'Here is your path:'
  path.each do |space|
    puts "\t#{space}"
  end
end

##
# Returns the shortest path a knight takes from +initial_space+ to
# +target_space+ using a Breadth-First-Search algorithm.
#
# +initial_space+::   The starting space of the knight.
# +target_space+::    The desired end space goal.
def find_knight_path(initial_space, target_space)
  return [initial_space] if initial_space == target_space

  paths = valid_knight_moves(initial_space).map { |move| [initial_space, move] }
  # Since this problem is guarenteed to have a solution,
  # it will eventually terminate.
  # See https://en.wikipedia.org/wiki/Knight%27s_tour
  loop do
    current_path = paths.shift
    new_path_points = valid_knight_moves(current_path[-1]) - current_path
    # Short-circut if the target is within the next move
    return current_path << target_space if new_path_points.include?(target_space)

    # Push new path with each move
    new_path_points.each { |move| paths << (current_path + [move]) }
  end
end

##
# Returns a list of valid moves for the knight chess piece.
#
# +current_space+:: The place where the knight starts from.
def valid_knight_moves(current_space)
  # No moves if space itself is not a valid space
  return [] unless valid_space?(current_space)

  # Extract coordinates
  x, y = current_space

  # Collect all possible moves
  valid_spaces = KNIGHT_MOVES_DELTA.each_with_object([]) do |move, accumulator|
    delta_x, delta_y = move
    test_space = [x + delta_x, y + delta_y]
    accumulator << test_space if valid_space?(test_space)
  end
end

##
# Determines whether a space is on the 8 x 8 game board for chess.
#
# +space+:: The space to test the validity of.
def valid_space?(space)
  space.all? { |coord| coord.between?(0, 7) }
end

knight_moves([0, 0], [7, 7])
