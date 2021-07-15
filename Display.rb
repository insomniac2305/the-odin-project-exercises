class Display

  def self print_instructions
    puts "This is Mastermind!"
  end

  def self code_to_color(code)
    puts code
  end

  def self print_code(code)
    puts code
  end

  def self print_guess_result(guess, feedback)
    puts guess + " " + feedback
  end
  
  def self ask_for_guess
    puts "Please type in your guess: "
  end

end