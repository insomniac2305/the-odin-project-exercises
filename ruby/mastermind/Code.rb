class Code

  CORRECT_POS = "*"
  CORRECT_COL = "?"
  ALL_CORRECT = [CORRECT_POS, CORRECT_POS, CORRECT_POS, CORRECT_POS]

  attr_accessor :numbers

  def initialize(numbers = [])
    @numbers = numbers
  end

  def compare_to_guess(code)
    feedback = []
    guess_num = Array.new(code.numbers)
    self_num = Array.new(self.numbers)

    guess_num.each_with_index do |x, i|
      if x == self_num[i]
        feedback.push(CORRECT_POS)
        guess_num[i] = nil
        self_num[i] = nil
      end
    end

    guess_num.compact!
    self_num.compact!

    guess_num.each_with_index do |x, i|
      if self_num.include?(x)
        feedback.push(CORRECT_COL)
        self_num.delete_at(self_num.index(x))
      end
    end

    return feedback
  end
end