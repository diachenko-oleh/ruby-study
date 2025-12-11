require_relative 'node'

class Tree
  attr_reader :root

  def initialize(arr)
    @root = build_tree(arr.sort)
  end

  def build_tree(arr)
    return nil if arr.nil? || arr.empty?

    middle = arr.length / 2
    root = Node.new(
      arr[middle],
      build_tree(arr[0...middle]),
      build_tree(arr[middle+1..-1])
    )

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value, node=@root)
    return nil if value.nil?
    return nil if node.nil?

    if(value==node.data)
      return "#{value} found"
    elsif(value<node.data)
      find(value, node.left)
    elsif (value>=node.data)
      find(value, node.right)
    end
  end
  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    return node if node.data == value #don't allow duplicates

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      node.data = getSuccessor(node.right)
      node.right = delete(node.data, node.right)
    end
    node
  end

  def level_order
    return nil if @root.nil?
    queue =  Queue.new
    answer = []
    queue<<@root
    until queue.empty?
      node = queue.pop
      answer<<node.data
      queue<<node.left if !node.left.nil?
      queue<<node.right if !node.right.nil?
    end
    return answer
  end

  def inorder
    return nil if @root.nil?
    stack = []
    answer = []
    node = @root
    while !stack.empty? || !node.nil?

      while !node.nil?
        stack.push(node)
        node = node.left
      end

      node = stack.pop
      answer<<node.data
      node = node.right

    end
    return answer
  end

  def preorder
    return nil if @root.nil?
    answer = []
    stack = []
    stack.push(@root)
    while !stack.empty?  
      node = stack.pop
      answer<<node.data
      stack.push(node.right) if !node.right.nil?
      stack.push(node.left) if !node.left.nil?
    end
    return answer
  end

  def postorder
    return nil if @root.nil?
    answer = []
    stack = []
    visited = []
    node = @root
    while !stack.empty? || !node.nil?
      while !node.nil?
        stack.push(node)
        node = node.left
      end

    node = stack.last
    if (node.left.nil? || visited.include?(node.left))&&(node.right.nil? || visited.include?(node.right))
      visited<<node
      answer<<node.data
      stack.pop
      node = nil
    else
      node=node.right
    end
    end
    return answer
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    [left_height, right_height].max + 1
  end

  def depth(value,node=@root,depth=0)
    if(value==node.data)
      return depth
    elsif(value<node.data)
      depth(value, node.left,depth+=1)
    elsif (value>=node.data)
      depth(value, node.right,depth+=1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    new_array = inorder
    @root = build_tree(new_array)

  end
end
