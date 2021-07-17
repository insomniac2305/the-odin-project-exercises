require "./Code.rb"
require "./Display.rb"
require "./HumanPlayer.rb"
require "./ComputerPlayer.rb"


class Game

  MAX_GUESSES = 12

  def initialize
      @secret_code = Code.new
  end

  private 

  def play_again?
    Display.ask_if_play_again
    again = gets.chomp.upcase
    return again == "Y"
  end

  public

  def start
    Display.print_instructions
    @secret_code = ComputerPlayer.select_code
    guesser_won = false
    MAX_GUESSES.times do
      guess = HumanPlayer.select_code
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