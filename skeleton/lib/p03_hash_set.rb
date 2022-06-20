class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    count = key.hash
    if !self.include?(key)
      self[count] << key
      @count += 1
      resize! if @count == @store.length
    end
  end

  def include?(key)
    count = key.hash
    return self[count].include?(key)
  end

  def remove(key)
    count = key.hash
    if self.include?(key)
      self[count].delete(key)
      @count -= 1
    end
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
    arr = Array.new(@store.length*2) {Array.new}
    @store.each do |bucket|
      bucket.each do |ele|
        count = ele.hash % arr.length
        arr[count] << ele
      end
    end
    @store = arr
  end
end
