class Display

  STATE_0 = <<-HANGMAN
    +---+
        |
        |
        |
        |
        |
  =========
  HANGMAN

  STATE_1 = <<-HANGMAN
    +---+
    |   |
        |
        |
        |
        |
  =========
  HANGMAN

  STATE_2 = <<-HANGMAN
    +---+
    |   |
    O   |
        |
        |
        |
  =========
  HANGMAN

  STATE_3 = <<-HANGMAN
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========
  HANGMAN

  STATE_4 = <<-HANGMAN
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========
  HANGMAN

  STATE_5 = <<-HANGMAN
    +---+
    |   |
    O   |
   /|\\  |
        |
        |
  =========
  HANGMAN

  STATE_6 = <<-HANGMAN
    +---+
    |   |
    O   |
   /|\\  |
   /    |
        |
  =========
  HANGMAN

  STATE_7 = <<-HANGMAN
    +---+
    |   |
    O   |
   /|\\  |
   / \\  |
        |
  =========
  HANGMAN
  
  def self.state(remaining_guesses)
    puts "\n" + [STATE_7, STATE_6, STATE_5, STATE_4, STATE_3, STATE_2, STATE_1, STATE_0][remaining_guesses]
    puts "You have #{remaining_guesses} tries left.\n\n"
  end

  def self.instructions
    puts "This is Hangman!"
    puts "The computer will randomly select a word and you have to guess it one character at a time to succeed."
    puts "Once the hangman is completed, the computer wins."
    puts "Good luck!\n\n"
  end

  def self.show_guesses(guesses)
    puts "So far you have guessed: #{guesses.join(", ")}\n\n"
  end

  def self.show_solution(solution)
    puts "Secret word: #{solution.join (" ")}"
  end

  def self.result(player_won, word)
    if player_won
      puts "Nice! You correctly guessed: #{word}"
    else
      puts "You lose, the word was: #{word}"
    end
  end

end
