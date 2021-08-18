# frozen_string_literal: true

# Node class for a linked list. A node
# contains data and also a link to the next node.
class Node
  attr_reader :value
  attr_accessor :next_node

  ##
  # Creates a node with a given value.
  def initialize(value = nil)
    @value = value
    @next_node = nil
  end

  ##
  # Defines what it means for two nodes to be equal
  def ==(other)
    return false unless other.is_a? Node

    value == other.value
  end

  ##
  # Represents the node as a string
  def to_s
    "( #{@value} )"
  end
end
