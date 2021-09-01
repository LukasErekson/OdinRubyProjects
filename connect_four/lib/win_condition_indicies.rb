# frozen_string_literal: true

# Generate the win index arrays for Connect Four and save to a .yml file

require 'yaml'

win_indices = []

# Vertical win conditions
(0..6).each do |col|
  (0..1).each do |row_start|
    vertical_win = []
    4.times do |i|
      vertical_win.append([col, row_start + i])
    end
    win_indices.append(vertical_win)
  end
end

# Horizontal win conditions
(0..5).each do |row|
  (0..2).each do |starting_col|
    horizontal_win = []
    4.times do |i|
      horizontal_win.append([starting_col + i, row])
    end
    win_indices.append(horizontal_win)
  end
end

# Diagonal win conditions \
(0..2).each do |starting_row|
  (0..3).each do |starting_col|
    left_diag_win = []
    4.times do |i|
      left_diag_win.append([starting_col + i, starting_row + i])
    end
    win_indices.append(left_diag_win)
  end
end

# Diagonal win conditions /
(0..2).reverse_each do |starting_row|
  (3..6).each do |starting_col|
    left_diag_win = []
    4.times do |i|
      left_diag_win.append([starting_col - i, starting_row + i])
    end
    win_indices.append(left_diag_win)
  end
end

File.open('./win_conditions.yml', 'w') do |file|
  file.write(win_indices.to_yaml)
end
