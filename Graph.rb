require "./KnightLocation.rb"
require "pry"

class ChessGraph

  attr_accessor :knight_locations

  @@POSSIBLE_MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

  def initialize

    @knight_locations = []

    for x in 1..8 do
      for y in 1..8 do
        @knight_locations.push(KnightLocation.new([x, y]))
      end
    end

    # binding.pry
    for loc in @knight_locations do
      for move in @@POSSIBLE_MOVES do
        new_x = loc.coordinates[0] + move[0]
        new_y = loc.coordinates[1] + move[1]
        if new_x.between?(1, 8) && new_y.between?(1, 8)
          target_index = @knight_locations.index { |kl| kl.coordinates == [new_x, new_y] }
          loc.moves.push(@knight_locations[target_index])
        end
      end
    end
  end
  
  def knight_move(start, dest)
    start_loc = get_location(start)
    dest_loc = get_location(dest)
    knight_move_rec(start_loc, dest_loc) if start_loc && dest_loc
  end

  def get_location(coordinates)
    loc_index = @knight_locations.index { |loc| loc.coordinates == coordinates }
    return @knight_locations[loc_index] if loc_index
  end

  private 

  def knight_move_rec(start, dest, queue = [], prev = [])
    return previous + [dest] if start == dest || start.moves.include?(dest)

    new_prev = Array.new(prev)
    new_prev.push(start)
    queue = queue + start.moves
    return knight_move(queue.pop, dest, queue, new_prev)
  end
end

chess = ChessGraph.new
puts chess.knight_move([5,5], [5,5])[0].to_s