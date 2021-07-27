# Create a hash of substrings mapping to their fequencies in the
# given string.
#
#   substrings("Well of course I know him; he's me! That's a meme.", ["our", "well", "me"]) 
#      #=> {"our" => 1, "well" => 1, "me" => 3}
#
def substrings(str, dictionary)
    # Make case insensitive for the input string.
    downcase_str = str.downcase
    dictionary.reduce(Hash.new(0)) do |accumulator, word|
        # Make case insensitive for the dictionary
        downcase_word = word.downcase
        word_frequency = downcase_str.gsub(downcase_word).to_a.length
        
        if word_frequency > 0
            accumulator[downcase_word] = word_frequency
        end

        accumulator
    end
end