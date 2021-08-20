# frozen_string_literal: true

require_relative 'node'

##
# Binary Search Tree class
class Tree
  include Enumerable
  attr_reader :root

  ##
  # Initializes a new Binary Search Tree with values from
  # +array+.
  #
  # +array+:: The array containing the values for the tree.
  # +_sorted+:: Whether or not the array is sorted.
  def initialize(array = [], sorted = false)
    raise TypeError, 'Tree requires an array to initialize.' unless array.is_a? Array

    # Extract unique elements for sorting
    build_array = array.uniq

    # Requires a sorted array to properly build the tree.
    build_array.sort! unless sorted

    @root = build_tree(build_array)
    
  end

  ##
  # Alias for pretty_print
  def to_s
    pretty_print
  end

  ##
  # Inserts a new node with +value+ into its appropriate
  # place in the tree. Returns +true+ if insertion was successful and false if
  # a node of that value already exists in the
  # tree.
  #
  # +value+:: The value of the new node to insert.
  def insert(value, current_node = @root)
    value = value.value if value.is_a? Node
    case value <=> current_node.value
    when 0 # Value already exists in the tree
      false
    when -1 # Left subtree
      if current_node.left.nil?
        current_node.left = Node.new(value)
        true
      else
        insert(value, current_node.left)
      end
    else # Right subtree
      if current_node.right.nil?
        current_node.right = Node.new(value)
        true
      else
        insert(value, current_node.right)
      end
    end
  end

  ##
  # Returns the height of +node+, or the number of
  # edges in the longest path from +node+ to a leaf node.
  #
  # +node+:: The node to find the height of.
  def height(node); end

  ##
  # Returns the depth of +node+, or the number of edges in
  # the path from +node+ to the +root+.
  #
  # +node+:: The node to find the depth of.
  def depth(node); end

  ##
  # Returns whether the tree is balanced or not.
  # To be balanced, the difference of the hieghts between
  # each left and right subtree of every node is not
  # more than 1.
  def balanced?; end

  ##
  # Balances an unbalanced tree.
  def rebalance
    # Short-circut if already balanced.
    return if balanced?
  end

  ##
  # Returns an array of the elements in level order.
  def level_order; end

  ##
  # Returns an array of elements using inorder
  def inorder; end

  ##
  # Returns an array of elements using preorder
  def preorder; end

  ##
  # Returns an array of elements using postorder
  def postorder; end

  ##
  # Allows iteration through the node values of the BST using different 
  # algorithms.
  #
  # A more efficient implementation is possible, but to hold
  # within the confines of The Odin Project project description,
  # it gets the array from a previous method and uses its
  # #each implementation.

  # +iter_method+:: The method with which to iterate through.
  # +&block+::      The block to apply each node value.
  def each(iter_method = '', &block)
    return unless block_given?

    order_arr = case iter_method
                when 'inorder'
                  inorder
                when 'preorder'
                  preorder
                when 'postorder'
                  postorder
                else # Use level order.
                  level_order
                end

    order_arr.each { |node_val, *args| block.call(node_val, *args) }

    # Return the array used
    order_arr
  end

  protected

  ##
  # Visualization of the binary tree, written by a community
  # member of The Odin Project. Mainly used for debugging, so
  # the spec file doesn't include any tests for this.
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  ##
  # Builds a binary search tree using values in a sorted array.
  #
  # +sorted_array+:: A sorted array to turn into a BST.
  def build_tree(sorted_array)
    return Node.new(sorted_array[0]) if sorted_array.length <= 1

    midpoint = sorted_array.length / 2
    subtree_root = Node.new(sorted_array[midpoint])
    subtree_root.left = build_tree(sorted_array[0...midpoint])
    subtree_root.right = build_tree(sorted_array[midpoint + 1..])

    subtree_root
  end
end
