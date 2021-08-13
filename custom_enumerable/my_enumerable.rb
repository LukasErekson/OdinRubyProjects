# frozen_string_literal: true

# Extension of the Enumerable module that re-implements a lot of Enumerable's
# key methods.
module Enumerable
  ##
  # Replicates the behavior of Enumerable.each
  def my_each
    return self unless block_given?

    if is_a? Array
      length.times { |idx| yield(self[idx]) }
    elsif is_a? Hash
      keys = self.keys
      vals = values
      length.times { |idx| yield(keys[idx], vals[idx]) }
    else
      warn 'Incompatible type!'
    end
    self
  end

  ##
  # Replicates the behavior of Enumerable.each_with_index
  def my_each_with_index
    return self unless block_given?

    if is_a? Array
      length.times { |idx| yield(self[idx], idx) }
    elsif is_a? Hash
      keys = self.keys
      vals = values
      length.times { |idx| yield([keys[idx], vals[idx]], idx) }
    else
      warn 'Incompatible type!'
    end
    self
  end

  ##
  # Replicates the behavior of Enumerable.select
  def my_select
    return self unless block_given?

    result = self.class.new

    if is_a? Array
      my_each { |val| result.push(val) if yield(val) }
    elsif is_a? Hash
      my_each { |key, val| result[key] = val if yield(key, val) }
    else
      warn 'Incompatible type!'
    end
    result
  end

  ##
  # Replicates the behavior of Enumerable.all?
  def my_all?(&block)
    return true unless block_given?

    

    return self.my_select(&block) == self
  end

  ##
  # Replicates the behavior of Enumerable.any?
end
