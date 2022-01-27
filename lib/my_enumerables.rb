# frozen-string-literal: true

# module
module Enumerable
  def my_each_with_index
    return unless block_given?

    index = 0
    while index < length
      yield(self[index], index)
      index += 1
    end
    self
  end

  def my_select
    new_array = []
    my_each do |value|
      new_array << value if yield(value) == true
    end
    new_array
  end

  def my_all?(match=nil)
    arr = []
    if block_given?
      my_each do |value|
        arr << value if yield(value) == true
      end
      return true if arr == self

      false
    else
      unless match.nil?
        my_each do |value|
          arr << value if match === value
        end
        return true if arr == self
      end
      return false if include?(false) || include?(nil)

      true
    end
  end

  def my_any?
    arr = []
    my_each do |value|
      arr << true if yield(value) == true
    end
    return true if arr.include?(true)

    false
  end

  def my_none?
    arr = []
    my_each do |value|
      arr << false if yield(value) == false
      arr << true if yield(value) == true
    end
    return false if arr.include?(true)

    true
  end

  def my_count(check = '')
    count = 0
    if block_given?
      my_each do |value|
        count += 1 if yield(value) == true
      end
      count
    else
      length
    end
  end

  def my_map
    arr = []
    my_each do |value|
      arr << yield(value)
    end
    arr
  end

  def my_inject(initial=nil)
    if !initial.nil?
      sum = initial
      my_each_with_index do |_value, index|
        if index.zero?
          sum = yield(sum, self[index + 1])
        elsif index <= length - 1
          sum = yield(sum, self[index])
        end
      end
    else
      sum = self[0]
      my_each_with_index do |_value, index|
        if index.zero?
          sum = yield(self[index], self[index + 1])
        elsif index <= length - 1
          sum = yield(sum, self[index])
        end
      end
    end
    sum
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return unless block_given?

    index = 0
    while index < length
      yield(self[index])
      index += 1
    end
    self
  end
end
