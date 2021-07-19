require "./Display.rb"
require "./Code.rb"

class HumanPlayer

  def select_secret_code
    return select_code
  end

  def select_code
    code = Code.new
    loop do

      Display.ask_for_code
      guess = gets.chomp
      code.numbers = guess.split("")
      code.numbers.map! {|n| n.to_i}

      unless code.numbers.all? {|n| n.between?(1,6)}
        Display.code_characters_invalid
        next
      end

      unless code.numbers.length == 4
        Display.code_length_invalid
        next
      end

      return code
    end
  end

  def process_feedback(guess, feedback)
    Display.guess_result(guess, feedback)
  end

end