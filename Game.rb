require "./Player.rb"
require "./GridField.rb"
require "pry"

class Game

  def initialize()    
    @player1 = Player.createNewPlayer(1)
    @player2 = Player.createNewPlayer(2)
    @playingField = GridField.new()
  end

  def playRound(player, selection)    
    unless selection.between?(1, GridField::CELL_COUNT)
      print "Selection out of bounds, please try again: "
      return false
    end

    row = GridField.selectionToRow(selection)
    column = GridField.selectionToColumn(selection)

    if @playingField.cellIsEmpty?(row, column)
      @playingField.setCell(row, column, player.symbol)
      return true
    else
      print "Field is already taken, please try again: " 
      return false
    end
  end

  def gameOver?(lastSelection)
    row = GridField.selectionToRow(lastSelection)
    column = GridField.selectionToColumn(lastSelection)

    return  GridField.rowCompleted?(row) || 
            GridField.columnCompleted?(column) ||
            (GridField::DIAGONAL_TOP_DOWN.include?([row, column]) && GridField.diagonalTopDownCompleted?) ||
            (GridField::DIAGONAL_BOTTOM_UP.include?([row, column]) && GridField.diagonalBottomUpCompleted?)

  end

  def start
    puts "Ready for Tic Tac Toe?"
    puts @playingField
    currentPlayer = @player2
    GridField::CELL_COUNT.times do
      currentPlayer = (currentPlayer == @player1 ? @player2 : @player1)
      print "#{currentPlayer.name}, select your field: "
      selection = gets.chomp.to_i
      selection = gets.chomp.to_i until playRound(currentPlayer, selection)
      puts @playingField
      if gameOver?(selection)
        puts ".. and the winner is: #{currentPlayer.name.upcase}!!!"
        return
      end
    end
    print "No winner this time, want to play again? [Y/N]:"
    again = gets.chomp
    self.start if again.upcase[0] == "Y"
    puts "Okay, bye!" if again.upcase[0] == "N"
  end

end

Game.new.start
