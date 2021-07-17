module Display

  CODE_COLORS = {
    1 => "\e[101m  1  \e[0m ",
    2 => "\e[43m  2  \e[0m ",
    3 => "\e[44m  3  \e[0m ",
    4 => "\e[45m  4  \e[0m ",
    5 => "\e[46m  5  \e[0m ",
    6 => "\e[41m  6  \e[0m ",
  }

  FEEDBACK_COLORS = {
    '*' => "\e[91m\u25CF\e[0m ",
    '?' => "\e[37m\u25CB\e[0m "
  }

  def self.print_instructions
    puts "This is Mastermind! Face off against the computer in making or breaking a 4-digit code"
    puts "The game is played with any of the following colors:"
    print_code(Code.new([1, 2, 3, 4, 5, 6]))
    puts ""    
    puts " #{FEEDBACK_COLORS['*']} means one of your guessed colors is already in the correct spot"
    puts " #{FEEDBACK_COLORS['?']} means you guessed one color correctly, but it's position is not right yet"
    puts "Now have fun breaking the code!"
  end

  def self.print_code(code)
    code.numbers.each do |c|
      print "#{CODE_COLORS[c]} "
    end
  end

  def self.print_feedback(feedback)
    feedback.each do |f|
      print "#{FEEDBACK_COLORS[f]} "
    end
  end

  def self.print_guess_result(guess, feedback)
    print_code(guess)
    print_feedback(feedback)
    puts ""
  end
  
  def self.ask_for_guess
    print "Please type in your guess: "
  end

  def self.code_characters_invalid
    puts "Your code contains invalid characters, please try again ..."
  end

  def self.code_length_invalid
    puts "Your code must be exactly 4 characters long, please try again ..."
  end

  def self.success_message
    puts "You won!"
  end

  def self.failure_message
    puts "You lost!"
  end

  def self.ask_if_play_again
    print "Do you want to play again? [y/n]: "
  end

end