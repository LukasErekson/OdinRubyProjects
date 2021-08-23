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
  # +value+::         The value of the new node to insert.
  # +current_node+::  The current node the method is looking at.
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
  # Deletes the node with +value+ passed in. Returns +true+ if it was
  # successfully removed, +false+ if no such node exists.
  #
  # +value+::         The value sought after to delete.
  # +current_node+::  The current node the method is looking at.
  def delete(value, current_node = @root)
    # Base case: We did not find the node
    return current_node if current_node.nil?

    if value < current_node.value
      current_node.left = delete(value, current_node.left)
    elsif value > current_node.value
      current_node.right = delete(value, current_node.right)
    elsif current_node.left.nil? # equality
      temp = current_node.right
      current_node = nil
      return temp

    elsif current_node.right.nil?
      temp = current_node.left
      current_node = nil
      return temp

    else # Node has 2 children.
      successor = find_inorder_successor(current_node.right)
      current_node.value = successor.value

      current_node.right = delete(successor.value, current_node.right)
    end
    current_node
  end

  ##
  # Finds the inorder sucessor of +node+ by finding the node with the
  # smallest value in the right subtree of +node+.
  #
  # +node+:: The node to find the inroder successor of.
  def find_inorder_successor(node)
    current_node = node
    current_node = current_node.left until current_node.left.nil?

    current_node
  end

  ##
  # Finds and returns a node with +value+ as its value.
  # Returns nil if no such node exists in the tree.
  #
  # +value+::         The value that is sought.
  # +current_node+::  The current node to compare +value+ to.
  def find(value, current_node = @root)
    # Base case: We found the node or past a leaf node
    return current_node if current_node.nil? || current_node.value == value

    return find(value, current_node.left) if value < current_node.value

    find(value, current_node.right)
  end

  ##
  # Returns the height of +node+, or the number of
  # edges in the longest path from +node+ to a leaf node.
  #
  # +node+:: The node to find the height of.
  def height(node)
    # Base case: We've reached past a leaf node (stop incrementing)
    return -1 if node.nil?

    # Otherwise, return the max of the left and right subtree heights.
    1 + [height(node.left), height(node.right)].max
  end

  ##
  # Returns the depth of +node+, or the number of edges in
  # the path from +node+ to the +root+.
  #
  # +sought_node+::  The node to find the depth of.
  # +current_node+:: The current node in the breadth first search.
  def depth(sought_node, current_node = @root)
    # Base case we've reached beyond a leaf node.
    return -1 if current_node.nil?

    # Base case: We've reached the node.
    return 0 if current_node == sought_node

    # Otherwise, return the minimum of the depths
    1 + [depth(sought_node, current_node.left), depth(sought_node, current_node.right)].max
  end

  ##
  # Returns whether the tree is balanced or not.
  # To be balanced, the difference of the heghts between
  # each left and right subtree of every noide is not
  # more than 1.
  def balanced?
    (height(@root.left) - height(root.right)).between?(-1, 1)
  end

  ##
  # Balances an unbalanced tree.
  def rebalance!
    # Short-circut if already balanced.
    return @root if balanced?

    @root = build_tree(inorder)
  end

  ##
  # Shorthand warpper for level_order_iter
  def level_order(only_vals: true)
    level_order_iter(only_vals: only_vals)
  end

  ##
  # Returns an array of the nodes in level order iteratively.
  #
  # +only_vals+:: Return an array of just the values if true. Otherwise, return
  #               an array of Node objects.
  def level_order_iter(only_vals: true)
    level_order_array = [@root]
    children_queue = [@root.left, @root.right]
    until children_queue.all?(&:nil?)
      # Dequeue the next child
      current_node = children_queue.shift
      next if current_node.nil?

      level_order_array << current_node
      # Queue up the left and rode nodes as children
      children_queue << current_node.left unless current_node.left.nil?

      children_queue << current_node.right unless current_node.right.nil?

    end

    # Return array of just the values if only_vals is true.
    only_vals ? level_order_array.map(&:value) : level_order_array
  end

  ##
  # Returns an array of the nodes in level order recursively.
  #
  # +level_order_array+:: The array of Node objects to return.
  # +children_queue+::    The queue of children who haven't been visited yet.
  def level_order_rec(level_order_array = [@root],
                      children_queue = [@root.left, @root.right],
                      only_vals: true)
    new_level_queue = []
    children_queue.each do |node|
      next if node.nil?

      new_level_queue << node.left unless node.left.nil?
      new_level_queue << node.right unless node.right.nil?
      level_order_array << node
    end
    # Base case is the new_level_queue is all nil.
    level_order_rec(level_order_array, new_level_queue, only_vals: only_vals) unless new_level_queue.all?(&:nil?)

    # Return array of just the values if only_vals is true.
    only_vals ? level_order_array.map(&:value) : level_order_array
  end

  ##
  # Returns an array of elements in the tree traversed using inorder.
  # Acts as a wrapper for #inorder_traverse to make the return array more
  # flexible.
  #
  # +only_vals+:: returns an array of Node values if +true+, otherwise it
  #               returns an array of Node objects.
  def inorder(only_vals: true)
    inorder_array = inorder_traverse
    # Return only values or array of node objects.
    only_vals ? inorder_array.map(&:value) : inorder_array
  end

  ##
  # Returns an array of elements using inorder.
  #
  # +current_node+:: The current node whose children are being looked at. This
  #                  node is added to inorder_array after its left child.
  def inorder_traverse(current_node = @root)
    inorder_array = []

    # Base case: reached child of a leaf node (nil)
    return [] if current_node.nil?

    inorder_array += inorder_traverse(current_node.left)
    inorder_array << current_node
    inorder_array += inorder_traverse(current_node.right)

    inorder_array
  end

  ##
  # Returns an array of elements in the tree traversed using preorder.
  # Acts as a wrapper for preorder_traverse to make the return array more
  # flexible.
  #
  # +only_vals+:: returns an array of Node values if +true+, otherwise it
  #               returns an array of Node objects.
  def preorder(only_vals: true)
    preorder_array = preorder_traverse
    # Return only values or array of node objects.
    only_vals ? preorder_array.map(&:value) : preorder_array
  end

  ##
  # Returns an array of elements using preorder.
  #
  # +current_node+:: The current node whose children are being looked at. This
  #                  node is added to inorder_array before its children.
  def preorder_traverse(current_node = @root)
    preorder_array = []

    # Base case: reached child of a leaf node (nil)
    return [] if current_node.nil?

    preorder_array << current_node
    preorder_array += preorder_traverse(current_node.left)
    preorder_array += preorder_traverse(current_node.right)

    preorder_array
  end

  ##
  # Returns an array of elements in the tree traversed using postorder.
  # Acts as a wrapper for postorder_traverse to make the return array more
  # flexible.
  #
  # +only_vals+:: returns an array of Node values if +true+, otherwise it
  #               returns an array of Node objects.
  def postorder(only_vals: true)
    postorder_array = postorder_traverse
    # Return only values or array of node objects.
    only_vals ? postorder_array.map(&:value) : postorder_array
  end

  ##
  # Returns an array of elements using postorder.
  #
  # +current_node+:: The current node whose children are being looked at. This
  #                  node is added to inorder_array after its children.
  def postorder_traverse(current_node = @root)
    postorder_array = []

    # Base case: reached child of a leaf node (nil)
    return [] if current_node.nil?

    postorder_array += postorder_traverse(current_node.left)
    postorder_array += postorder_traverse(current_node.right)
    postorder_array << current_node

    postorder_array
  end

  ##
  # Allows iteration through the node values of the BST using different algorithms.
  #
  # A more efficient implementation is possible, but to hold
  # within the confines of The Odin Project project description,
  # it gets the array from a previous method and uses its
  # #each implementation.

  # +iter_method+:: The method with which to iterate through.
  # +vals_only+::   Whether or not the iteration should be of the values only or the nodes.
  # +&block+::      The block to apply each node value.
  def each(iter_method = '', vals_only: true, &block)
    return unless block_given?

    order_arr = case iter_method
                when 'inorder'
                  inorder(vals_only: vals_only)
                when 'preorder'
                  preorder(vals_only: vals_only)
                when 'postorder'
                  postorder(vals_only: vals_only)
                else # Use level order.
                  level_order(vals_only: vals_only)
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
    return if sorted_array.length.zero?

    return Node.new(sorted_array[0]) if sorted_array.length == 1

    midpoint = (sorted_array.length - 1) / 2
    subtree_root = Node.new(sorted_array[midpoint])
    # Don't include the root in the left subtree.
    subtree_root.left = build_tree(sorted_array[0...midpoint])
    subtree_root.right = build_tree(sorted_array[midpoint + 1..-1])

    subtree_root
  end
end
