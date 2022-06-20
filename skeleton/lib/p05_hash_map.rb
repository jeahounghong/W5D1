require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
    
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    buck = bucket(key)
    return @store[buck].include?(key)
  end

  def set(key, val)
    buck = bucket(key)
    if !@store[buck].include?(key)
      @store[buck].append(key,val)
      @count += 1
      resize! if @count == @store.length
    else
      @store[buck].update(key,val)
    end
  end

  def get(key)
    buck = bucket(key)
    return @store[buck].get(key)
  end

  def delete(key)
    buck = bucket(key)
    if @store[buck].include?(key)
      @store[buck].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key,node.val]
      end
    end
  end

  #uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new(@store.length * 2) {LinkedList.new}
    self.each do |k,v|
      buck = k.hash % arr.length
      arr[buck].append(k,v)
    end
    @store = arr
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    return key.hash % @store.length
  end
end
