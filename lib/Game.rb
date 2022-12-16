require_relative "Player"
require_relative "GridField"

class Game

  def initialize(player1 = Player.create_new_player(1),
                player2 = Player.create_new_player(2),
                playingField = GridField.new())
    @player1 = player1
    @player2 = player2
    @playingField = playingField
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
    
    return  @playingField.rowCompleted?(row) || 
            @playingField.columnCompleted?(column) ||
            (GridField::DIAGONAL_TOP_DOWN.include?([row, column]) && @playingField.diagonalTopDownCompleted?) ||
            (GridField::DIAGONAL_BOTTOM_UP.include?([row, column]) && @playingField.diagonalBottomUpCompleted?)

  end

  def start
    puts "Ready for Tic Tac Toe?"
    gameWon = false
    currentPlayer = [@player1, @player2].shuffle[0]
    @playingField.clear    
    puts @playingField

    GridField::CELL_COUNT.times do
      currentPlayer = (currentPlayer == @player1 ? @player2 : @player1)
      print "#{currentPlayer.name}, select your field: "
      selection = gets.chomp.to_i
      selection = gets.chomp.to_i until playRound(currentPlayer, selection)
      puts @playingField

      if gameOver?(selection)
        gameWon = true
        break
      end
    end

    puts gameWon ? "... and the winner is: #{currentPlayer.name.upcase}!!!" : "No winner this time ..."
    print "Want to play again? [Y/N]:"
    again = gets.chomp
    puts "Okay, bye!" if again.upcase[0] == "N"    
    self.start if again.upcase[0] == "Y"
  end

end