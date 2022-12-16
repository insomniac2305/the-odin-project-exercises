class KnightLocation

  attr_reader :coordinates
  attr_accessor :moves

  def initialize(coordinates, moves = [])
    @coordinates = coordinates
    @moves = moves
  end

  def to_s
    @coordinates.to_s
  end
end