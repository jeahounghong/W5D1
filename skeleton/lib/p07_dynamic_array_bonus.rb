class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  attr_accessor :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0
      j = 0
      while @store[j] != nil
        j += 1
      end
      i = j + i
    end


    @store[i] if (0...@store.length).to_a.include?(i)
  end

  def []=(i, val)
    if i < 0
      j = 0
      while @store[j] != nil
        j += 1
      end
      i = j + i
    end

    if i >= @store.length
      new_store = StaticArray.new(i+1)
      j = 0
      while j < @store.length do 
        new_store[j] = @store[j]
        j += 1
      end
      # while j < new_store.length do
      #   new_store[]
      #   j += 1
      # end
      @store= new_store
    end


    @store[i] = val if (0...@store.length).to_a.include?(i)
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < @store.length
      return true if @store[i]== val
      i += 1
    end
    false
  end

  def push(val)
    resize! if @count == @store.length
    if @store[@store.length-1] == nil
      
      i = 0
      while @store[i] != nil
        i += 1
      end
      @store[i] = val
      @count += 1
    end
    
    # new_store = StaticArray.new(@store.length + 1)
    # i = 0
    # while i < @store.length  do
    #   new_store[i] = @store[i]
    #   i += 1
    # end
    # new_store[i] = val
    # @store = new_store
    
  end

  def unshift(val)
    resize! if @count == @store.length
    i = @store.length-1
    while i > 0 do
      @store[i] = @store[i-1]
      i -=1
    end
    @store[0] = val
    @count += 1
  end

  def pop
    i = @store.length - 1
    while @store[i] == nil && i > 0 do
      i -=1
    end
    temp = @store[i]
    @store[i] = nil
    @count -= 1
    return temp


  end

  def shift
    # return nil if @store[0] == nil
    i = 0
    temp = @store[0]
    while i < @store.length - 1 do
      @store[i] = @store[i+1]
      i += 1
    end
    @store[@store.length-1] = nil
    @count -= 1

    return temp

  end

  def first
    return self[0]
  end

  def last
    i = 0
    while i < @store.length - 1 do 
      break if @store[i+1] == nil
      i += 1
    end
    return self[i]
  end

  def each
    i = 0
    while i < @store.length do 
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    if other.is_a?(Array)
      other.each_with_index do |el,i|
        return false if el != @store[i]
      end
      return true
    else 
      i = 0
      while i < other.count
        return false if other[i] != @store[i]
        i+= 1
      end
      return true

    end
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@store.length*2)
    i = 0
    while i < @store.length
      new_store[i] = @store[i]
      i += 1
    end
    @store = new_store
  end
end
