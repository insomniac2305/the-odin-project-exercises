require "./Code.rb"

class ComputerPlayer

  def initialize
    @possible_codes = []
    for a in 1..6 do
      for b in 1..6 do
        for c in 1..6 do
          for d in 1..6 do
            @possible_codes.push(Code.new([a, b, c, d]))
          end
        end
      end
    end
    @first_turn = true
  end

  def select_secret_code
    code = Code.new
    4.times {code.numbers.push(rand(1..6))}
    return code
  end

  def select_code
    if @first_turn
      @first_turn = false
      return Code.new([1, 1, 2, 2]) 
    else
      return @possible_codes[0]
    end    
  end

  def process_feedback(guess, feedback)
    @possible_codes.delete_if { |c| c.compare_to_guess(guess) != feedback}
    Display.guess_result(guess, feedback)
  end

end