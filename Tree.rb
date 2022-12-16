require "./Node.rb"

class Tree

  attr_reader :root

  def initialize(array)    
    @root = build_tree(array.uniq.sort)
  end

  private 

  def build_tree(array)    
    return nil if array === nil || array.length == 0

    mid = (array.length / 2).to_i
    root = Node.new(array[mid])

    root.left = build_tree(array.slice(0, mid))

    root.right = build_tree(array.slice(mid + 1..array.length))

    return root
  end

  public

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

  def level_order(root = @root, queue = [])
    if root
      print "#{root.data} "
      queue.push(root.left)
      queue.push(root.right)
    end    
    level_order(queue.shift, queue) unless queue.empty?
  end
  
  def to_level_order_arr(root = @root, queue = [], result = [])
    if root
      result.push(root.data)
      queue.push(root.left)
      queue.push(root.right)
    end

    to_level_order_arr(queue.shift, queue, result) unless queue.empty?
    return result
  end

  def inorder(root = @root)
    return root unless root
    inorder(root.left)
    print "#{root.data} "
    inorder(root.right)
  end

  def to_inorder_arr(root = @root, result = [])
    return result unless root
    to_inorder_arr(root.left, result)
    result.push(root.data)
    to_inorder_arr(root.right, result)
  end
  
  def preorder(root = @root)
    return root unless root
    print "#{root.data} "
    preorder(root.left)
    preorder(root.right)
  end
  
  def postorder(root = @root)
    return root unless root
    postorder(root.left)
    postorder(root.right)
    print "#{root.data} "
  end

  def height(node, current_height = 0)
    return current_height unless node
    current_height += 1 

    left_height = height(node.left, current_height)
    right_height = height(node.right, current_height)

    return left_height > right_height ? left_height : right_height
  end

  def depth(node, current_node = @root, current_depth = 0)
    return 0 unless current_node && node
    current_depth += 1
    return current_depth if node == current_node
    next_node = (node.data < current_node.data ? current_node.left : current_node.right)
    return depth(node, next_node, current_depth)
  end

  def balanced?(root = @root)
    return true unless root
    is_balanced = (height(root.left) - height(root.right)).between?(-1, 1)
    subtrees_balanced = balanced?(root.left) && balanced?(root.right)
    return is_balanced && subtrees_balanced    
  end

  def rebalance
    sorted_values = to_inorder_arr
    @root = build_tree(sorted_values)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

# Driver Script
puts "Generate tree with random numbers < 100"
rand_num = Array.new(20) {rand(1..100)}
test_tree = Tree.new(rand_num)
test_tree.pretty_print
puts "\nBalanced: #{test_tree.balanced?}"
print "\nLevel Order: "
test_tree.level_order
print "\nPre Order: "
test_tree.preorder
print "\nIn Order: " 
test_tree.inorder
print "\nPost Order: " 
test_tree.postorder

puts "\nInserting random numbers > 100"
5.times { test_tree.insert(rand(100..1000)) }
test_tree.pretty_print
puts "\nBalanced: #{test_tree.balanced?}"

puts "Rebalancing ..."
test_tree.rebalance
test_tree.pretty_print
puts "\nBalanced: #{test_tree.balanced?}"
print "\nLevel Order: "
test_tree.level_order
print "\nPre Order: "
test_tree.preorder
print "\nIn Order: " 
test_tree.inorder
print "\nPost Order: " 
test_tree.postorder
