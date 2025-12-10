class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end


class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    node = Node.new(value)
    @tail.next_node = node unless @tail.nil?
    @tail = node
    @head = node if @head.nil?
    @size += 1
  end

  def prepend(value)
    node = Node.new(value, @tail)
    node.next_node = @head
    @head = node
    @tail = node if @tail.nil?
    @size += 1
  end

  def at(index)
    index += @size if index.negative?
    return unless index.between?(0, @size - 1)

    curr_node = @head
    index.times { curr_node = curr_node.next_node }
    curr_node
  end

  def pop 
    return if @head.nil?

    popped_value = @tail.value

    if @head == @tail
      @head, @tail = nil
    else
      curr_node = at(-2)
      curr_node.next_node = nil
      @tail = curr_node
    end

    @size -= 1
    popped_value
  end

  def contains?(value)
    !find(value).nil?
  end

  def find(value)
    curr_node = @head
    curr_index = 0

    until curr_node.nil?
      return curr_index if curr_node.value == value

      curr_node = curr_node.next_node
      curr_index += 1
    end

    nil
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

p list