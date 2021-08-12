# frozen_string_literal: true

require 'yaml'
require_relative 'hangman_game'

##
# A display for the Hangman game that handles all input and output.
class GameDisplay
  ##
  # Create a new game and enter a new hash for valid save_game_files.
  def initialize
    # The current game loaded to be played.
    @current_game = HangmanGame.new
    # The hash of valid save files. Used when loading files.
    populate_save_hash

    # Whether or not the game was saved and therefore the loop should break.
    @game_saved = false
  end

  ##
  # Play the current game loaded into the display.
  def play_current_game
    until @current_game.win_or_lose?
      print_display
      player_input
      break if @current_game.win_or_lose?
    end
    end_current_game
  end

  ##
  # Print off the display for each round
  def print_display
    puts @current_game.output_str
    puts "You have #{@current_game.num_fails_left}/8 wrong gueses."
    puts "Previous incorrect guesses: #{@current_game.incorrect_letters.reduce { |acc, letter| "#{acc} #{letter}" }}"
  end

  ##
  # End the current game and show the proper ending
  def end_current_game
    case @current_game.game_over
    when 'win'
      puts 'Congratulations! You won!'
      puts "The word was #{@current_game.reveal_target_word}."
    when 'lose'
      puts "Unfortunately, you lost. The word was #{@current_game.reveal_target_word}."
    end
    # Delete save file at game over to avoid cheating or clutter.
    unless @current_game.game_over == 'save'
      File.delete("saves/#{@current_game.file_name}.yaml") if File.exist?("saves/#{@current_game.file_name}.yaml")
      populate_save_hash
    end
    @current_game = HangmanGame.new
  end

  ##
  # Record and process the input from the player, either guessing a letter or
  # initializing a saved game.
  #
  # If given an invalid input, prompt the player until a valid input is given.
  def player_input
    puts 'Guess a letter or write "save" or "quit".'
    input_string = gets.chomp.upcase
    if input_string.length == 1
      @current_game.guess_letter(input_string)
    elsif input_string.include?('SAVE') || input_string.include?('QUIT')
      save_game
      # Set game_over to break the main loop.
      @current_game.game_over = 'save'
    else
      raise StandardError('Invalid input')
    end
  rescue StandardError
    puts 'Invalid guess. Please either input a single letter or "save"/"quit"'
    retry
  end

  ##
  # Save the game by serializing the current game instance into a chosen
  # file name.
  def save_game
    puts 'Please input a filename:'
    # Avoid allowing user to choose the extension.
    filename = gets.chomp.delete('.')
    if File.exist? "./saves/#{filename}.yaml"
      puts "The file ./saves/#{filename}.yaml already exists."
      puts 'Do you want to overwrite this file? [y/n]'
      response = gets.chomp.upcase
      raise StandardError('Invalid Response.') unless response == 'Y'
    end
    write_to_file filename
    # Indicate the loop should break and store the new file in the hash.
    @game_saved = true
    populate_save_hash
  rescue StandardError
    retry
  end

  ##
  # Writes the save data to given name+.
  def write_to_file(filename)
    serialized_game = YAML.dump @current_game
    save_file = File.open("./saves/#{filename}.yaml", 'w+')
    save_file.write serialized_game
    save_file.close
  end

  ##
  # Prompt and process the input from the player to load a game.
  def load_game
    puts 'Please choose a savefile by typing the name (or number) of a file from this list:'
    display_save_files
    player_input = gets.chomp
    filename = @save_game_hash[player_input.to_i] || player_input
    @current_game = YAML.load(File.open("saves/#{filename}.yaml", 'r'))
    # Set filename for proper deletion at the end.
    @current_game.file_name = filename
  rescue StandardError
    puts "saves/#{filename}.yaml doesn't exist" unless File.exist? "saves/#{filename}/yaml"

    puts 'Please input an alternate file name:'
    retry
  end

  ##
  # Display all of the options for save files and populate the save_game_hash.
  def display_save_files
    @save_game_hash.each { |idx, name| puts "#{idx}. #{name}" }
  end

  ##
  # Create a hash of valid save files with corresponding values
  def populate_save_hash
    # Reset the hash before repopulating
    @save_game_hash = {}
    Dir.glob('./saves/*').each_with_index do |name, idx|
      @save_game_hash[idx + 1] = name[8...-5]
    end
  end
end
