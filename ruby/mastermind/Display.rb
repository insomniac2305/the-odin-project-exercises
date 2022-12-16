module Display

  CODE_COLORS = {
    1 => "\e[101m  1  \e[0m ",
    2 => "\e[43m  2  \e[0m ",
    3 => "\e[44m  3  \e[0m ",
    4 => "\e[45m  4  \e[0m ",
    5 => "\e[46m  5  \e[0m ",
    6 => "\e[41m  6  \e[0m "
  }

  FEEDBACK_COLORS = {
    '*' => "\e[91m\u25CF\e[0m ",
    '?' => "\e[37m\u25CB\e[0m "
  }

  RESULT_MESSAGES = {
    "breaker-1" => "You lose. The computer broke your code, better luck next time!",
    "breaker-2" => "You broke the computer's code, congratulations!",
    "maker-1" => "The computer was not able to break your code in the given turns, you win!",
    "maker-2" => "You lose, as you were not able to break the code in the given turns. Better luck next time!"
  }

  def self.instructions
    puts "This is Mastermind! Face off against the computer in making or breaking a 4-digit code"
    puts "The game is played with any of the following colors:\n\n"
    code(Code.new([1, 2, 3, 4, 5, 6]))
    puts "\n\n"    
    puts " #{FEEDBACK_COLORS['*']} means one of your guessed colors is already in the correct spot"
    puts " #{FEEDBACK_COLORS['?']} means you guessed one color correctly, but it's position is not right yet\n\n"
  end

  def self.code(code)
    code.numbers.each do |c|
      print "#{CODE_COLORS[c]} "
    end
  end

  def self.feedback(feedback)
    feedback.each do |f|
      print "#{FEEDBACK_COLORS[f]} "
    end
  end

  def self.guess_result(guess, feedback)
    code(guess)
    feedback(feedback)
    puts "\n\n"
  end
  
  def self.ask_for_code
    print "Please type in your code: "
  end

  def self.code_characters_invalid
    puts "Your code contains invalid characters, please try again ..."
  end

  def self.code_length_invalid
    puts "Your code must be exactly 4 characters long, please try again ..."
  end

  def self.ask_for_game_mode
    puts "Do you want to make or break the code?\n\n"
    puts "[1] Maker"
    puts "[2] Breaker\n\n"
    print "Please choose the game mode: "
  end

  def self.invalid_game_mode
    print "This is not a valid game mode! Please choose again: "
  end

  def self.game_result(result)
    puts RESULT_MESSAGES[result]
  end

  def self.ask_if_play_again
    print "\nDo you want to play again? [y/n]: "
  end

end