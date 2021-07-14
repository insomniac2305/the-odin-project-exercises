class Game

  def initialize
      @secret_code = Code.new
      @total_guesses = 0
  end

  def select_code
    return @secret_code
  end

  def take_guess(code)
    return @secret_code.compare_to_guess(code)
  end

  def start
    return @secret_code
  end

end