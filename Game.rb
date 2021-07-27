require "./Display.rb"

class Game

  def initialize
    @dictionary = load_dictionary
    @secret = select_random_word.split("")
    @solution = []
    @secret.length.times { @solution.push "_"}
    @guesses = []
    @remaining_guesses = 7
  end

  private

  def load_dictionary
    if File.exist?("dictionary.txt")
      dictionary = File.readlines("dictionary.txt", chomp: true) 
    else
      puts "Dictionary not found!"
    end

    dictionary.select {|line| line.length.between?(5, 12)}
  end

  def select_random_word
    num = rand(@dictionary.length)
    @dictionary[num]
  end

  def check_input?(char)
    if char.length > 1
      print "Please guess only one char at a time, try again: "
      return false
    elsif @guesses.include?(char) 
      print "You already guessed this character before, try again: "
      return false
    else
      return true
    end
  end

  def guess_char(char)    
    @guesses.push(char)
    if @secret.include?(char)
      @secret.each_with_index { |c, i| @solution[i] = char if c == char }
    else
      @remaining_guesses -= 1
    end    
  end 

  public

  def start
    Display.instructions
    Display.state(@remaining_guesses)
    Display.show_solution(@solution)

    while @remaining_guesses > 0
      print "Please input your guess: "
      guess = gets.chomp.downcase
      guess = gets.chomp.downcase while !check_input?(guess)
      guess_char(guess)

      Display.state(@remaining_guesses)
      Display.show_solution(@solution)
      Display.show_guesses(@guesses)
      
      break if @secret == @solution
    end

    Display.result(@remaining_guesses > 0, @secret.join)

  end

end

Game.new.start