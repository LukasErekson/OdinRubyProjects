# frozen_string_literal: true

##
# Node class to be part of a binary tree; has a left
# and right child as well as a value.
class Node
  include Comparable
  attr_accessor :value

  attr_reader :left, :right

  ##
  # Creates a node with nil values
  #
  # +value+:: The value for the node to hold.
  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

  ##
  # Compares nodesbased on their value
  #
  # +other+:: The other node to compare values.
  def <=>(other)
    @value <=> other.value
  end

  ##
  # Calculates and returns the number of children the node has
  def num_children
    if @left.nil?
      1
    else
      0 + @right.nil? ? 1 : 0
    end
  end

  ##
  # Assigns the left child unless +other+ is not a Node object or nil.
  def left=(other)
    raise TypeError, 'Left must be a node or nil.' unless other.is_a?(Node) || other.nil?

    @left = other
  end

  ##
  # Assigns the right child unless +other+ is not a Node object or nil.
  #
  # +other:: The value to
  def right=(other)
    raise TypeError, 'Right must be a node or nil.' unless other.is_a?(Node) || other.nil?

    @right = other
  end

  ##
  # Represents the node as a string with its value and children.
  def to_s
    "[ value: #{@value} Left: #{@left} Right: #{@right} ]"
  end
end
