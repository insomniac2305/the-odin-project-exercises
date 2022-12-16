require "./KnightLocation.rb"

class KnightGraph

  @@POSSIBLE_MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

  def initialize

    @knight_locations = []

    for x in 1..8 do
      for y in 1..8 do
        @knight_locations.push(KnightLocation.new([x, y]))
      end
    end

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

    return "You're already there!" if start == dest
    start_loc = get_location(start)
    dest_loc = get_location(dest)
    
    path = nil
    max_depth = 1
    
    if start_loc && dest_loc
      until path
        path = search_path(start_loc, dest_loc, max_depth) 
        max_depth += 1
      end
    end
    
    if path
      output = "You made it in #{path.size - 1} #{path.size == 2 ? "move" : "moves"}! Here's your path:"
      path.each { |loc| output += "\n#{loc}" }
    else
      output = "That's not possible!"
    end
    
    return output

  end
  
  private 

  def get_location(coordinates)
    loc_index = @knight_locations.index { |loc| loc.coordinates == coordinates }
    return @knight_locations[loc_index] if loc_index
  end
  
  def search_path(start, dest, max_depth, cur_depth = 0, cur_path = [])
    cur_path = Array.new(cur_path)
    cur_path.push(start)

    if start.moves.include?(dest)
      cur_path.push(dest)
      return cur_path
    elsif cur_depth + 1 >= max_depth
      return nil
    else
      for move in start.moves do
        unless cur_path.include? move
          path = search_path(move, dest, max_depth, cur_depth + 1, cur_path) 
          return path if path
        end
      end
    end

    return nil
  end
end

chess = KnightGraph.new
puts chess.knight_move([3,3], [4,3])