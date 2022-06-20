class MaxIntSet

  attr_reader :store
  def initialize(max)
    @store = Array.new(max) {false}

  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num] if !is_valid?(num)
  end

  private

  def is_valid?(num)
    return num >= @store.length || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    return self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num 
      @count += 1
      resize! if @count == @store.length
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end

  end

  def include?(num)
    return self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count == @store.length
      @store_2 = Array.new(2*@store.length) { Array.new }
      @store.each do |bucket|
        bucket.each do |num|
          @store_2[num % @store_2.length] << num
        end
      end
      @store = @store_2

    end
  end
end
