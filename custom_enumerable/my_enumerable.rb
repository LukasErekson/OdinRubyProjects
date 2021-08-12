# frozen_string_literal: true

module Enumerable
  def my_each
    return self unless block_given?

    if self.is_a? Array
      self.length.times { |idx| yield(self[idx]) }
    elsif self.is_a? Hash
      keys = self.keys
      vals = self.values
      self.length.times { |idx| yield(keys[idx], vals[idx]) }
    else
      warn 'Incompatible type!'
    end
    self
  end
end
