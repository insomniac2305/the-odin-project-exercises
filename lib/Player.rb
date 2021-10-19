class Player
  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def self.create_new_player(number)
    print "Please input name of Player #{number}: "    
    while (name = gets.chomp).empty?
      print "Please input name of Player #{number}: "
    end
    
    print print "Please input symbol of Player #{number}: "
    while (symbol = gets.chomp[0]).empty?
      print print "Please input symbol of Player #{number}: "
    end

    return Player.new(name, symbol)
  end

  def ==(other)
    return (self.name == other.name) && (self.symbol == other.symbol)
  end
end