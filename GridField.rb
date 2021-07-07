class GridField
  
  def initialize(size)
    @content = Array.new(size) {Array.new(size, "")}
  end

  def cellIsEmpty?(row, column)
    @content[row][column] === ""
  end

  def setCell(row, column, value)
    @content[row][column] = value
  end

  def to_s
    output = "-----------------\n"

    selection = 0

    @content.each do |row|
      output += "|"
      row.each { |cell| output+= " #{selection += 1}[#{cell.empty? ? ' ' : cell}]" }
      output += " |\n"
    end

    output += "-----------------"
    return output
  end

end