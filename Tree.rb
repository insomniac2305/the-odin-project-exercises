require "./Node.rb"
require "pry"

class Tree

  attr_reader :root

  def initialize(array)    
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    # binding.pry
    return nil if array === nil || array.length == 0

    mid = (array.length / 2).to_i
    root = Node.new(array[mid])

    root.left = build_tree(array.slice(0, mid))

    root.right = build_tree(array.slice(mid + 1..array.length))

    return root

  end

  def insert(key, root = @root)

    return Node.new(key) if root.nil? || root.data == key
    (root.left = insert(key, root.left)) if key < root.data
    (root.right = insert(key, root.right)) if key > root.data
    return root

  end

  def delete(key, root = @root)

    return root unless root

    if key < root.data
      root.left = delete(key, root.left)
    elsif key > root.data
      root.right = delete(key, root.right)
    else
      return root.right unless root.left
      return root.left unless root.right

      root.data = find_min(root.right)

      root.right = delete(root.data, root.right)
    end

    return root

  end

  def find_min(root = @root)
    return root unless root
    return root.data unless root.left
    return find_min(root.left)
  end

  def find(key, root = @root)
    return root if root.nil? || root.data == key
    return find(key, root.left) if key < root.data
    return find(key, root.right) if key > root.data
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(arr)
tree.pretty_print
tree.insert(21)
tree.insert(21)
tree.insert(2)
tree.insert(-1)
tree.delete(-1)
tree.delete(3)
tree.delete(8)
tree.insert(3)
tree.insert(6)
tree.delete(4)
tree.pretty_print
p tree.find(67)