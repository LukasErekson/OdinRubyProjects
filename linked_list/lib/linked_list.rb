# frozen_string_literal: true

require_relative 'node'
require_relative 'empty_list_error'
# Linked List class. Contains a list of node objects
class LinkedList
  attr_reader :head, :tail, :size

  include Enumerable
  ##
  # Initializes the linked list with no initial nodes
  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  ##
  # Iterates through each of of the values in the linked list
  def each(&block)
    current_node = @head
    until current_node.nil?
      block.call(current_node)
      current_node = current_node.next_node
    end
  end

  ##
  # Appends a node with +value+ as the new tail of the list.
  def append(value)
    old_tail = @tail
    @tail = Node.new(value)
    old_tail.next_node = @tail unless old_tail.nil?

    @size += 1
    @head = @tail if size == 1
  end

  ##
  # Prepends a node with +value+ as the new head of the list.
  def prepend(value)
    old_head = @head
    @head = Node.new(value)
    @head.next_node = old_head unless old_head.nil?

    @size += 1
    @tail = @head if size == 1
  end

  ##
  # Returns the node at +idx+ (zero-based indexing)
  def at(idx)
    current_node = @head
    idx.times { current_node = current_node.next_node }
    current_node
  end

  ##
  # Alias for at
  def [](idx)
    at(idx)
  end

  ##
  # Removes and returns the head or list of items
  #
  # +num_pop+:: The amonunt of times to pop.
  def pop(num_pop = 1)
    raise EmptyListError, 'Cannot pop an empty list.' if @size.zero?

    pop_arr = []
    [num_pop, @size].min.times do
      old_tail = @tail
      @size -= 1
      @tail = at(@size - 1)
      @tail.next_node = nil
      pop_arr.append(old_tail)
    end
    num_pop == 1 ? pop_arr[0] : pop_arr
  end

  ##
  # Returns whether or not the list contains +value+
  def contains?(value)
    each { |node| return true if node.value == value }
    false
  end

  ##
  # Returns the index of the node with value +value+
  # Returns +nil+ if no such node is in the list
  def find(value)
    each_with_index do |node, idx|
      return idx if node.value == value
    end

    nil
  end

  ##
  # Inserts a new node with +value+ at +idx+
  # Returns +true+ if insertion was succssful
  def insert_at(value, idx)
    raise EmptyListError, "Cannot insert at index #{idx}; the list is empty." if @size.zero? && idx != 0
    raise IndexError, "#{idx} is out of bounds for list of size #{@size}" unless idx.between?(0, @size)

    case idx
    when 0
      prepend(value)
    when @size - 1
      append(value)
    else
      new_node = Node.new(value)
      new_node.next_node = at(idx)
      at(idx - 1).next_node = new_node
      @size += 1
    end
    # return whether insertion was successful
    at(idx).value == value
  end

  ##
  # Removes and returns the node at +idx+
  def remove_at(idx)
    raise EmptyListError, "Cannot remove at index #{idx}; the list is empty." if @size.zero?
    raise IndexError, "#{idx} is out of bounds for list of size #{@size}" unless idx.between?(0, @size)

    removed_node = at(idx)
    at(idx - 1).next_node = at(idx + 1)
    removed_node.next_node = nil
    @size -= 1

    removed_node
  end

  ##
  # Represents the linked list as a string
  def to_s
    result_str = ''
    each do |node|
      result_str += "#{node} -> "
    end
    "#{result_str}nil"
  end
end
