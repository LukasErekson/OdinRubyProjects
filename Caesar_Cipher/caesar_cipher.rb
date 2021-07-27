# Convert a string to its corresponding cipher message (using only the English
# alphabet, A-Z) by shifting the characters one at a time.
#
#	caesar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"
#   Caesar_cipher("I have a bad feeling about this, Chewie!", 17) #=> "Z yrmv r sru wvvczex rsflk kyzj, Tyvnzv!""
 
def caesar_cipher(message, shift_factor)
	# All shifts can be expressed as a positive integer
	# between 0 and 25.
	shift = shift_factor % 26

	# Terminate early if shift does nothing.
	if shift == 0
		puts "The ciphertext is identical to the message. (#{shift_factor} % 26 == 0)"
		return message
	end

	cipher = ""
	
	message.each_char do |char|
		shifted_char_num = char.ord
		# Handle Uppercase and Lowercase English
		# letters differently.
		if char.match(/[A-Z]/)
			shifted_char_num += shift
			if shifted_char_num > 90
					shifted_char_num -= 26
			end
		elsif char.match(/[a-z]/)
			shifted_char_num += shift
			if shifted_char_num > 122
					shifted_char_num -= 26
			end
		end

		cipher += shifted_char_num.chr
		
	end

	return cipher
	
end