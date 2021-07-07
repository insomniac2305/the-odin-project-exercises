require "./Player.rb"
require "./GridField.rb"
require "pry"

class Game

  @@fieldSize = 3
  @@cellCount = @@fieldSize**2

  def initialize()    
    @player1 = Player.createNewPlayer(1)
    @player2 = Player.createNewPlayer(2)
    @playingField = GridField.new(@@fieldSize)
  end

  def playRound(player, selection)    
    unless selection.between?(1, @@cellCount)
      print "Selection out of bounds, please try again: "
      return false
    end

    row = (selection - 1)/@@fieldSize
    column = (selection - 1)% @@fieldSize

    if @playingField.cellIsEmpty?(row, column)
      @playingField.setCell(row, column, player.symbol)
      return true
    else
      print "Field is already taken, please try again: " 
      return false
    end
  end

  def gameOver?

  end

  def start
    puts "Ready for Tic Tac Toe?"
    puts @playingField
    currentPlayer = @player2
    @@cellCount.times do
      currentPlayer = (currentPlayer == @player1 ? @player2 : @player1)
      print "#{currentPlayer.name} select your field: "
      selection = gets.chomp.to_i
      selection = gets.chomp.to_i until playRound(currentPlayer, selection)
      puts @playingField
      return currentPlayer if gameOver?
    end
    print "No winner this time, want to play again? [Y/N]:"
    again = gets.chomp
    self.start if again.upcase[0] == "Y"
    puts "Okay, bye!" if again.upcase[0] == "N"
  end

end

Game.new.start
