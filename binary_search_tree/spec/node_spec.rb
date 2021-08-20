# frozen_string_literal: true

require_relative '../lib/node'

RSpec.describe Node, 'BST Node' do
  context '#initialize' do
    node = Node.new(5)

    it 'assigns argument to value properly' do
      expect(node.value).to eq(5)
    end

    it 'assigns left child to nil' do
      expect(node.left).to eq(nil)
    end

    it 'assigns right child to nil' do
      expect(node.right).to eq(nil)
    end
  end

  context 'Changing attributes' do
    node = Node.new('hello')

    it 'overwrites value' do
      node.value = 'world'
      expect(node.value).to eq('world')
    end

    it 'overwrites left child given a Node' do
      node.left = Node.new(nil)
      expect(node.left).to eq(Node.new(nil))
    end

    it 'overwrites left child given nil' do
      node.left = nil
      expect(node.left).to eq(nil)
    end

    it 'raises a TypeError if left is assigned anything not a Node or nil' do
      expect { node.left = 10 }.to raise_error { TypeError.new('Left must be a node or nil.') }
    end

    it 'overwrites right child given a Node' do
      node.right = Node.new(nil)
      expect(node.right).to eq(Node.new(nil))
    end

    it 'overwrites right child given nil' do
      node.right = nil
      expect(node.right).to eq(nil)
    end

    it 'raises a TypeError if right is assigned anything not a Node or nil' do
      expect { node.right = 10 }.to raise_error { TypeError.new('Right must be a node or nil.') }
    end
  end

  context 'Comparable mixin implementation' do
    node_array = [Node.new(1), Node.new(4), Node.new(3), Node.new(2)]

    it 'compares based on values' do
      node_array.each do |node_left|
        node_array.each do |node_right|
          expect(node_left < node_right).to eq(node_left.value < node_right.value)
        end
      end
    end

    it 'allows an array of nodes to be sorted' do
      sorted_array = [Node.new(1), Node.new(2), Node.new(3), Node.new(4)]
      expect(node_array.sort).to eq(sorted_array)
    end
  end

  context '#to_s' do
    node = Node.new('Root')
    node.left = Node.new('Lefty')
    node.right = Node.new('Righty')

    it 'returns the expected string' do
      expected_str = '[ value: Root Left: [ value: Lefty Left:  Right:  ] Right: [ value: Righty Left:  Right:  ] ]'
      expect(node.to_s).to eq(expected_str)
    end
  end
end
