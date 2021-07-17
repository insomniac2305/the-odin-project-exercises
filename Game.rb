require "./Code.rb"
require "./Display.rb"

class Game

  MAX_GUESSES = 12

  def initialize
      @secret_code = Code.new
      @total_guesses = 0
  end

  private 

  def select_code
    numbers = []
    4.times {numbers.push(rand(1..6))}
    @secret_code.numbers = numbers
    return @secret_code
  end

  def make_guess
    code = Code.new
    loop do

      Display.ask_for_guess
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

  def play_again?
    Display.ask_if_play_again
    again = gets.chomp.upcase
    return again == "Y"
  end

  public

  def start
    Display.print_instructions
    @secret_code = select_code
    guesser_won = false
    MAX_GUESSES.times do
      guess = make_guess
      feedback = @secret_code.compare_to_guess(guess)
      Display.print_guess_result(guess, feedback)
      guesser_won = (feedback == Code::ALL_CORRECT)
      break if guesser_won
    end
    
    guesser_won ? Display.success_message : Display.failure_message
    self.start if play_again?
    
  end

end

Game.new.start