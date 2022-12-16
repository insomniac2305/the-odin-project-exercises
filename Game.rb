require "./Code.rb"
require "./Display.rb"
require "./HumanPlayer.rb"
require "./ComputerPlayer.rb"


class Game

  MAX_GUESSES = 12
  GM_MAKER = 1
  GM_BREAKER = 2

  def initialize
      @secret_code = Code.new
      @code_maker = nil
      @code_breaker = nil
      @game_mode = 0
  end

  private 

  def play_again?
    Display.ask_if_play_again
    again = gets.chomp.upcase
    return again == "Y"
  end

  def choose_game_mode
    Display.ask_for_game_mode
    loop do
      @game_mode = gets.chomp.to_i
      case @game_mode
      when GM_MAKER
        @code_maker = HumanPlayer.new
        @code_breaker = ComputerPlayer.new
      when GM_BREAKER        
        @code_maker = ComputerPlayer.new
        @code_breaker = HumanPlayer.new
      else
        Display.invalid_game_mode
      end
      break if @game_mode == GM_MAKER || @game_mode == GM_BREAKER
    end
  end

  def announce_result(breaker_won)
    result = breaker_won ? "breaker-" : "maker-"
    result += @game_mode.to_s
    Display.game_result(result)
  end

  public

  def start
    Display.instructions

    choose_game_mode
    @secret_code = @code_maker.select_secret_code
    breaker_won = false

    MAX_GUESSES.times do
      guess = @code_breaker.select_code
      feedback = @secret_code.compare_to_guess(guess)
      @code_breaker.process_feedback(guess, feedback)
      breaker_won = (feedback == Code::ALL_CORRECT)
      break if breaker_won
    end
    
    announce_result(breaker_won)
    self.start if play_again?
    
  end

end

Game.new.start