require "./Display.rb"
require "pry"

class Game

  attr_reader :secret, :solution, :guesses, :remaining_guesses

  def initialize
    @secret = select_random_word.split("")
    @solution = []
    @secret.length.times { @solution.push "_"}
    @guesses = []
    @remaining_guesses = 7
  end

  private

  def select_random_word
    if File.exist?("dictionary.txt")
      dictionary = File.readlines("dictionary.txt", chomp: true) 
    else
      puts "Dictionary not found!"
    end

    dictionary.select {|line| line.length.between?(5, 12)}
    num = rand(dictionary.length)
    dictionary[num]
  end

  def check_input?(char)
    if char.length != 1
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

  def start_new_game?
    input = gets.chomp
    case input
    when "1"
      return true
    when "2"
      return false
    else
      print "Please select new game [1] or load game [2]: "
      return start_new_game?
    end
  end

  def save
    save_file = File.open("game.sav", "w")
    save_data = Marshal.dump(self)
    save_file.puts save_data
    save_file.close
  end

  def load
    if File.exist?("game.sav")
      save_file = File.open("game.sav", "r")
      save_data = save_file.read    
      save_game = Marshal.load(save_data)
      save_file.close
      
      @secret = save_game.secret
      @solution = save_game.solution
      @guesses = save_game.guesses
      @remaining_guesses = save_game.remaining_guesses
    else
      puts "No save file found! Starting new game instead ..."
    end
  end

  public

  def start
    Display.instructions
    new_game = start_new_game?
    load unless new_game

    while @remaining_guesses > 0
      Display.state(@remaining_guesses)
      Display.show_solution(@solution)
      Display.show_guesses(@guesses) if !@guesses.empty?
      print "Please input your guess (or # to save and quit): "
      guess = gets.chomp.downcase
      guess = gets.chomp.downcase while !check_input?(guess)

      if guess == "#"
        save
        return
      end

      guess_char(guess)

      
      break if @secret == @solution
    end

    Display.result(@remaining_guesses > 0, @secret.join)
    
  end

end

Game.new.start
