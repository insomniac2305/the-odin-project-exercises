require "./node.rb"
require "pry"

class LinkedList

  attr_reader :head, :tail

  def append(value)
    new_node = Node.new(value)
    
    unless @head
      @head = new_node
      @tail = head
      return @head
    end

    @tail.next_node = new_node
    @tail = new_node	
    return @tail
  end

  def prepend(value)
    return append(value) unless @head
    
    new_node = Node.new(value, @head)
    @head = new_node
    return @head
  end

  def size(start = @head)
    return 0 unless @head
    return 1 if @head === @tail
    return start.next_node ? size(start.next_node) + 1 : 1
  end

  def at(index, current = @head)
    return current if index == 0
    return at(index - 1, current.next_node) if current.next_node
  end

  def pop
    popped_node = @tail
    @tail = at(size - 2)
    @tail.next_node = nil
    return popped_node
  end

  def contains?(value, current = @head)
    return true if current.value == value
    return false unless current.next_node
    return contains?(value, current.next_node)
  end

  def find(value, index = 0, current = @head)
    return index if current.value == value
    return find(value, index + 1, current.next_node) if current.next_node
  end

  def to_s(current = @head)
    return "nil" unless current
    return "( #{current.value} ) -> #{to_s(current.next_node)}"
  end

  def insert_at(value, index)
    raise StandardError.new "Index out of bounds" unless index.between?(0, size-1)
    new_node = Node.new(value, at(index))
    index == 0 ? @head = new_node : at(index - 1).next_node = new_node
  end

  def remove_at(index)
    last_index = size - 1
    raise StandardError.new "Index out of bounds" unless index.between?(0, last_index)
    
    if index == 0
      removed_node = @head
      @head = @head.next_node
      return removed_node
    end
    
    previous_node = at(index-1)
    removed_node = previous_node.next_node
    next_node = previous_node.next_node.next_node
    
    if index == last_index
      @tail = previous_node
      @tail.next_node = nil
    else
      previous_node.next_node = next_node
    end
    
    return removed_node
  end
  
end


list = LinkedList.new()
list.append(1)
list.append(2)
list.append(3)
list.prepend(5)

p list
p list.size
p list.at(1)
p list.pop
p list.contains? 2
p list.find(3)

puts list
list.insert_at(4, 2)
puts list
list.remove_at(3)
puts list