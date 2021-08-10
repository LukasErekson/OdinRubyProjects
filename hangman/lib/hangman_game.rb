# frozen_string_literal: true

##
# A class contaning everything needed for a terminal game of hangman.
class HangmanGame
  # The lcoation of the word bank from which to choose the target word.
  WORD_BANK_FNAME = '5desk.txt'
  attr_reader :output_str, :correct_letters, :incorrect_letters,\
              :num_fails_left, :win, :lose

  ##
  # Start a new game with an optional player name, potentially loading a
  # save file to initialize the variables.
  def initialize(player_name = 'Player')
    # The letters a player has guessed that are in the target word.
    @correct_letters = []
    # The letters a player has guessed that are not in the target word.
    @incorrect_letters = []
    # The word the player is trying to guess.
    @target_word = choose_target_word
    # The name of the player (optional parameter)
    @player_name = player_name
    # The string to display to give the player feedback.
    @output_str = '_ ' * @target_word.length
    # The number of guesses the player has left
    @num_fails_left = 8
    # Whether the player has won or not
    @win = false
    # Whether the player has lost (run out of guesses without guessing the word)
    @lose = false
  end

  ##
  # See if +letter+ has been guessed before and if it hasn't been, put it in
  # either +@correct_letters+ or +@incorrect_letters+.
  def guess_letter(letter)
    if @correct_letters.include?(letter) || @incorrect_letters.include?(letter)
      puts "You have already guessed #{letter}."
    elsif @target_word.include? letter
      @correct_letters.append(letter)
      update_output_str(letter)
    else
      @incorrect_letters.append(letter)
      @num_fails_left -= 1
    end
  end

  ##
  # Replace every instance of the underscores corresponding to +letter+
  # with _letter+.
  def update_output_str(letter)
    idx_of_letter = @target_word.index(letter)
    until idx_of_letter.nil?
      @output_str[idx_of_letter * 2] = letter
      idx_of_letter = @target_word.index(letter, idx_of_letter + 1)
    end
  end

  ##
  # Check whether the player has won or lost the game.
  def win_or_lose?
    @win = @output_str.count('_').zero?
    @lose = true if @num_fails_left.zero? && !@win
  end

  ##
  # Reveal the target word only if the player has lost the game.
  def reveal_target_word
    return @target_word if @lose
  end

  protected

  ##
  # Choose a random target word from the dictionary.
  def choose_target_word
    chosen_word = ''
    word_bank = File.open(WORD_BANK_FNAME, 'r')
    num_lines = word_bank.reduce(0) { |count, _| count + 1 }
    until chosen_word.length.between?(5, 12)
      word_bank.rewind
      Random.rand(num_lines).times { word_bank.readline }
      chosen_word = word_bank.readline.chomp.upcase
    end
    chosen_word
  end
end
