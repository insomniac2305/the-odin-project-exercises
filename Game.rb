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
    return @secret_code
  end

  def make_guess
    Display.ask_for_guess
    guess = gets.chomp    
  end

  def play_again?
    return false
  end

  public

  def start
    Display.print_instructions
    @secret_code = select_code
    guesser_won = false
    MAX_GUESSES.times do
      guess = Code.new(make_guess)
      feedback = @secret_code.compare_to_guess(guess)
      Display.print_guess_result(guess, feedback)
      guesser_won = (feedback == Code::ALL_CORRECT)
      break if guesser_won
    end
    
    guesser_won ? Display.print_success_message : Display.print_failure_message
    self.start if play_again?
    
  end

end