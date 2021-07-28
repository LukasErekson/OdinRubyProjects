# Swap two elements in an array (modifies in place)
def swap(array, idx1, idx2)
	temp = array[idx1]
	array[idx1] = array[idx2]
	array[idx2] = temp
	return nil
end

# Sort an unsorted array using the bubble sort algorithm
def bubble_sort(unsorted_array)
	# Copy the array (arrays are mutable)
	sorted_array = Array.new(unsorted_array)
	
	array_length = unsorted_array.length
	(array_length - 1).times do |num_sorted|
		(array_length - num_sorted - 1).times do |idx|
			if sorted_array[idx] > sorted_array[idx + 1]
				swap(sorted_array, idx, idx + 1)
			end
		end
	end

	sorted_array
end
