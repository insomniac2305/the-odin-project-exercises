class GridField

  FIELD_SIZE = 3
  CELL_COUNT = FIELD_SIZE**2
  DIAGONAL_TOP_DOWN = [[0, 0], [1, 1], [2, 2]]
  DIAGONAL_BOTTOM_UP = [[2, 0], [1, 1], [0, 2]]
  
  def initialize()
    @content = Array.new(FIELD_SIZE) {Array.new(FIELD_SIZE, " ")}
  end

  def cellIsEmpty?(row, column)
    @content[row][column] === " "
  end

  def setCell(row, column, value)
    @content[row][column] = value
  end

  def to_s
    output = "-----------------\n"

    selection = 0

    @content.each do |row|
      output += "|"
      row.each { |cell| output+= " #{selection += 1}[#{cell}]" }
      output += " |\n"
    end

    output += "-----------------"
    return output
  end

  def self.selectionToRow(selection)
    (selection - 1)/FIELD_SIZE
  end

  def self.selectionToColumn(selection)
    (selection - 1)%FIELD_SIZE
  end

  def rowCompleted?(row)
    @content[row].difference([@content[row][0]]).eql?([])
  end

  def columnCompleted?(column)
    columnToCheck = [@content[0][column], @content[1][column], @content[2][column]]
    columnToCheck.difference([columnToCheck[0]]).eql?([])
  end

  def diagonalTopDownCompleted?
    diagonalToCheck = [@content[0][0], @content[1][1], @content[2][2]]
    diagonalToCheck.difference([diagonalToCheck[0]]).eql?([])
end

  def diagonalBottomUpCompleted?
    diagonalToCheck = [@content[2][0], @content[1][1], @content[0][2]]
    diagonalToCheck.difference([diagonalToCheck[0]]).eql?([])
  end

  def clear
    self.initialize
  end

end