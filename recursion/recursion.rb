# frozen_string_literal: true

##
# Calculates the nth fibonacci number iteratively.
#
# +idx+:: The index of the desired fibonacci number.
def fibs(idx)
  return 1 if idx == 1

  previous = [0, 1]
  fib_number = 0
  # n - 1 t get indexing right.
  (idx - 1).times do
    fib_number = previous.shift + previous[0]
    previous.append(fib_number)
  end
  fib_number
end

##
# Calculates the nth fibonacci number recursively.
#
# +n+:: The index of the desired fibonacci number.
def fibs_rec(idx)
  # Base case: the fibonacci number equals its index
  return idx if [0, 1].include?(idx)

  fibs_rec(idx - 1) + fibs_rec(idx - 2)
end

##
# Merges sorted arrays

# +arr1+:: The first array to sort.
# +arr2+:: the second sorted array to merge.
def merge_sorted_arrays(_arr1, _arr2)
  sorted_arr = []
  until left_sorted.empty? && right_sorted.empty?
    if left_sorted[0].nil? || right_sorted[0].nil?
      sorted_arr.append left_sorted.shift || right_sorted.shift
    elsif left_sorted[0] < right_sorted[0]
      sorted_arr.append left_sorted.shift
    else
      sorted_arr.append right_sorted.shift
    end
  end
  sorted_arr
end

##
# Sorts an array using the recursive mergesort algorithm.
#
# +arr+:: The array to sort.
def mergesort(arr)
  # Base case: Arrays of length 1 are sorted.
  return arr if arr.length == 1

  left_sorted = mergesort(arr[0...arr.length / 2])

  right_sorted = mergesort(arr[arr.length / 2..])

  # Merge and return sorted arrays
  merge_sorted_arrays(left_sorted, right_sorted)
end
