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

    # Return false as early as possible
    my_each { |*args| return false unless block.call(*args) }

    true
  end

  ##
  # Replicates the behavior of Enumerable.any?
  def my_any?(&block)
    return false unless block_given?

    # Return true on first instance
    my_each { |*args| return true if block.call(*args) }

    false
  end

  ##
  # Replicates the behavior of Enumerable.none?
  def my_none?(&block)
    return true unless block_given?

    # Exit with false as early as possible.
    my_each { |*args| return false if block.call(*args) }

    true
  end

  ##
  # Replicates the behavior of Enumerable.count
  def my_count(&block)
    return 0 unless block_given?

    counter = 0

    my_each { |*args| counter += 1 if block.call(*args) }

    counter
  end

  ##
  # Replicates the behavior of Enumerable.map
  def my_map(optional_proc = nil, &block)
    # Accept either a block or a proc
    if optional_proc.nil?
      return to_enum(:my_map) unless block_given?
    else
      block = optional_proc
    end

    result = []
    my_each { |*args| result.push(block.call(*args)) }

    result
  end

  ##
  # Replicates the behavior of Enumerable.inject
  def my_inject(initial_value = nil, &block)
    raise StandardError('no block given') unless block_given?

    accumulator = initial_value

    my_each do |*args|
      if accumulator.nil
        accumulator = sfirst
        next
      end
      accumulator = block.call(accumulator, *args)
    end

    accumulator
  end
end
