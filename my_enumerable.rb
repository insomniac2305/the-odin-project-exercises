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

end
