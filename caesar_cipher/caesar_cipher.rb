# frozen_string_literal: true

##
# Shifts each given character by +shift_factor+, looping around where
# necessary and maintaining capitalization.
# Note: This only works for the English alphabet: A-Z and a-z.
#
# +char+::	The character to shift.
# +shift+::	The number of characters to shift +char+ by.
def shift_char(char, shift)
  shifted_char_num = char.ord
  case char
  when /[A-Z]/
    shifted_char_num += shift
    shifted_char_num -= 26 if shifted_char_num > 90
  when /[a-z]/
    shifted_char_num += shift
    shifted_char_num -= 26 if shifted_char_num > 122
  end
  shifted_char_num.chr
end

##
# Convert a string to its corresponding cipher message (using only the English
# alphabet, A-Z) by shifting the characters one at a time.
#
#
# +message+:: 			The string message to encode/decode
# +shift_factor+::	How many characters to shift by.
#
# ==== Examples
#	caesar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"
# caesar_cipher("I have a bad feeling about this, Chewie!", 17) #=> "Z yrmv r sru wvvczex rsflk kyzj, Tyvnzv!""
def caesar_cipher(message, shift_factor)
  # All shifts can be expressed as a positive integer
  # between 0 and 25.
  shift = shift_factor % 26

  # Terminate early if shift does nothing.
  if shift.zero?
    warn "The ciphertext is identical to the message. (#{shift_factor} % 26 == 0)"
    return message
  end
  cipher = ''
  message.each_char do |char|
    cipher += shift_char(char, shift)
  end
  cipher
end
