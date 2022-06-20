# require 'enumerable'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    # each_with_index { |link, j| return link if i == j }
    # nil
    @current_node = @head.next
    j = 0
    until @current_node == @tail
      return @current_node if j == i
      @current_node = @current_node.next
      j += 1
    end
    nil

  end

  def first
    return @head.next
  end

  def last
    return @tail.prev
  end

  def empty?
    return @head.next == @tail
  end

  def get(key)
    @current_node = @head
    until @current_node.next == nil
      return @current_node.val if @current_node.key == key
      @current_node = @current_node.next
    end
    nil
  end

  def include?(key)
    @current_node = @head
    until @current_node.next == nil
      return true if @current_node.key == key
      @current_node = @current_node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    if self.empty?
      @head.next = new_node
      new_node.prev = @head
      @tail.prev = new_node
      new_node.next = @tail
      return nil
    else
      @current_node = @tail.prev
      @current_node.next = new_node
      new_node.prev = @current_node
      @tail.prev = new_node
      new_node.next = @tail
      return nil
    end
  end

  def update(key, val)
    @current_node = @head
    until @current_node.next == nil
      @current_node.val = val if @current_node.key == key
      @current_node = @current_node.next
    end
  end

  def remove(key)
    @current_node = @head
    until @current_node.next == nil
      @current_node.remove if @current_node.key == key
      @current_node = @current_node.next
    end
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
