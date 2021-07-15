class Code

  CORRECT_POS = "*"
  CORRECT_COL = "?"
  ALL_CORRECT = CORRECT_POS + CORRECT_POS + CORRECT_POS + CORRECT_POS

  def initialize
    @numbers = []
  end

  def compare_to_guess(code)
    feedback = []
    return feedback
  end

  def numbers=(numbers)
    @numbers = numbers
  end
end