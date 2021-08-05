module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    return self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    return self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    result = []
    self.my_each {|value| result << value if yield(value)}
    return result
  end
  
  def my_all?(pattern = nil)
    result = true
    if block_given?
      self.my_each { |value| result = false unless yield(value)}
    end
    if pattern
      self.my_each do |value|
        case value
        in ^pattern
          :match
        else 
          result = false
        end
      end
    end
    return result
  end

  def my_any?(pattern = nil)
    result = false
    if block_given?
      self.my_each { |value| result = true if yield(value)}
    end
    if pattern
      self.my_each do |value|
        case value
        in ^pattern
          result = true
        else 
          :no_match
        end
      end
    end
    return result
  end

  def my_none?(pattern = nil)
    result = true
    if block_given?
      self.my_each { |value| result = false if yield(value)}
    end
    if pattern
      self.my_each do |value|
        case value
        in ^pattern
          result = false
        else 
          :no_match
        end
      end
    end
    return result
  end

  def my_count(item = nil)
    count = self.length
    if block_given?
      count = 0
      self.my_each { |value| count += 1 if yield(value) } 
    elsif item
      count = my_count { |value| value == item }
    end
    return count
  end

  def my_map(mapping = nil)
    return to_enum(:my_map) unless block_given? || mapping
    result = []
    self.my_each do |value| 
      result << (mapping ? mapping.call(value) : yield(value))
    end
    return result
  end
  
  def my_inject(initial = nil, sym = nil)

    if initial && !initial.is_a?(Symbol)
      memo = initial
      i = 0
    else
      memo = self.first
      i = 1
    end

    sym = initial if initial.is_a?(Symbol) && !block_given?

    while i < self.length
      memo = block_given? ? yield(memo, self[i]) : memo.send(sym, self[i])
      i += 1
    end
    return memo
  end

end
