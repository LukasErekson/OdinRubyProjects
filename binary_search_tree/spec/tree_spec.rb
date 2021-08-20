# frozen_string_literal: true

require_relative '../lib/node'
require_relative '../lib/tree'

RSpec.describe Tree, 'Binary Search Tree' do
  context '#initialize' do
    it 'takes in an (empty) array' do
      my_tree = Tree.new([])
    end

    it 'raises a TypeError if not given an array' do
      expect { my_tree = Tree.new('Pine') }.to raise_error { TypeError.new('Tree requires an array to initialize.') }
    end

    it 'allows access to the root attribute' do
      my_tree = Tree.new([1, 2, 3], true)
      expect(my_tree.root).to eq(Node.new(2))
    end

    it 'builds a simple balanced tree' do
      my_tree = Tree.new([1, 2, 3], true)
      expected_output = { root: Node.new(2), left: Node.new(1), right: Node.new(3) }
      actual_output = { root: my_tree.root, left: my_tree.root.left, right: my_tree.root.right }
      expect(actual_output).to eq(expected_output)
    end

    it 'build a simple balanced tree with duplicates in the array' do
      my_tree = Tree.new([1, 2, 3, 2, 3])
      expected_output = { root: Node.new(2), left: Node.new(1), right: Node.new(3) }
      actual_output = { root: my_tree.root, left: my_tree.root.left, right: my_tree.root.right }
      expect(actual_output).to eq(expected_output)
    end

    it 'builds a balanced tree with random integers' do
      my_tree = Tree.new(Array.new(15) { rand(1..100) })
      expect(my_tree.balanced?).to eq(true)
    end
  end

  context '#insert' do
    it 'returns true on a successful insertion' do
      my_tree = Tree.new([1, 2, 3])
      expect(my_tree.insert(4)).to eq(true)
    end

    it 'returns false for a value already in the tree' do
      my_tree = Tree.new([1, 2, 3])
      expect(my_tree.insert(2)).to eq(false)
    end

    it 'accepts node objects' do
      my_tree = Tree.new([1, 2, 3])
      expect(my_tree.insert(Node.new(4))).to eq(true)
    end

    it 'returns false for a node already in the tree' do
      my_tree = Tree.new([1, 2, 3])
      expect(my_tree.insert(Node.new(3))).to eq(false)
    end
  end
end
