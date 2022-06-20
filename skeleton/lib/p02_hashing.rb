class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    alpha = ("a".."z").to_a
    count = 0
    self.each_with_index do |el,i|
      if el.is_a?(String)
        el.each_char.with_index do |c,j|
          if alpha.include?(c.downcase)
            count += 10 + alpha.index(c.downcase)*j*i
          else
            count += alpha.to_i*i
          end
        end
      else
        count += el.to_s.to_i*i
      end
    end
    count = count.to_s(2)
    return count.to_i(2)

  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    count = 0
    self.each_char.with_index do |c,i|
      if alpha.include?(c.downcase)
        count += 10 + alpha.index(c.downcase)*i
      else
        count += alpha.to_i
      end
    end
    count = count.to_s(2)
    return count.to_i(2)

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    count = 0
    alpha = ("a".."z").to_a
    self.each do |k,v|
      if k.is_a?(String)
        count += k.hash
      elsif k.is_a?(Array)
        count += k.hash
      else
        count += k.hash
      end

      count += v.hash
    end
    return count
  end
end
