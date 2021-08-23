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

    it 'builds a simple balanced tree with duplicates in the array' do
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

  context '#delete' do
    it 'removes element with no children' do
      my_tree = Tree.new([1, 2, 3])
      my_tree.delete(3)
    end

    it 'removes element with one child' do
      my_tree = Tree.new([1, 2, 3, 4])
      my_tree.delete(2)
    end

    it 'removes element with two children' do
      my_tree = Tree.new([1, 2, 3])
      my_tree.delete(2)
    end

    it 'removes element whose child has children' do
      my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8])
      my_tree.delete(7)
    end

    it 'removes element whose children have children' do
      my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8])
      my_tree.delete(5)
    end
  end

  context '#level_order_iter' do
    balanced_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    balanced_tree_level_order = [4, 2, 6, 1, 3, 5, 7]
    unbalanced_tree = Tree.new([1, 2, 3])
    unbalanced_tree.insert(5)
    unbalanced_tree.insert(7)
    unbalanced_tree_level_order = [2, 1, 3, 5, 7]

    it 'returns array of values in level order for a balanced tree' do
      expect(balanced_tree.level_order_iter).to eq(balanced_tree_level_order)
    end

    it 'returns array of nodes in level order for a balanced tree and only_vals = false' do
      node_balanced_tree_level_order = balanced_tree_level_order.map { |val| Node.new(val) }
      expect(balanced_tree.level_order_iter(only_vals: false)).to eq(node_balanced_tree_level_order)
    end

    it 'returns array of values in level order for an unbalanced tree' do
      expect(unbalanced_tree.level_order_iter).to eq(unbalanced_tree_level_order)
    end

    it 'returns array of nodes in elvel order for an unbalanced tree and only_vals = false' do
      node_unbalanced_tree_level_order = unbalanced_tree_level_order.map { |val| Node.new(val) }
      expect(unbalanced_tree.level_order_iter(only_vals: false)).to eq(node_unbalanced_tree_level_order)
    end
  end

  context '#level_order_rec' do
    balanced_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    balanced_tree_level_order = [4, 2, 6, 1, 3, 5, 7]
    unbalanced_tree = Tree.new([1, 2, 3])
    unbalanced_tree.insert(5)
    unbalanced_tree.insert(7)
    unbalanced_tree_level_order = [2, 1, 3, 5, 7]

    it 'returns array of values in level order for a balanced tree' do
      expect(balanced_tree.level_order_rec).to eq(balanced_tree_level_order)
    end

    it 'returns array of nodes in level order for a balanced tree and only_vals = false' do
      node_balanced_tree_level_order = balanced_tree_level_order.map { |val| Node.new(val) }
      expect(balanced_tree.level_order_rec(only_vals: false)).to eq(node_balanced_tree_level_order)
    end

    it 'returns array of values in level order for an unbalanced tree' do
      expect(unbalanced_tree.level_order_rec).to eq(unbalanced_tree_level_order)
    end

    it 'returns array of nodes in level order for an unbalanced tree and only_vals = false' do
      node_unbalanced_tree_level_order = unbalanced_tree_level_order.map { |val| Node.new(val) }
      expect(unbalanced_tree.level_order_rec(only_vals: false)).to eq(node_unbalanced_tree_level_order)
    end
  end

  context '#inorder' do
    balanced_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    balanced_tree_inorder = [1, 2, 3, 4, 5, 6, 7]
    unbalanced_tree = Tree.new([1, 2, 3])
    unbalanced_tree.insert(5)
    unbalanced_tree.insert(7)
    unbalanced_tree_inorder = [1, 2, 3, 5, 7]

    it 'returns array of values using inorder for a balanced tree' do
      expect(balanced_tree.inorder).to eq(balanced_tree_inorder)
    end

    it 'returns array of nodes using inorder for a balanced tree and only_vals = false' do
      node_balanced_tree_inorder = balanced_tree_inorder.map { |val| Node.new(val) }
      expect(balanced_tree.inorder(only_vals: false)).to eq(node_balanced_tree_inorder)
    end

    it 'returns array of values using inorder for an unbalanced tree' do
      expect(unbalanced_tree.inorder).to eq(unbalanced_tree_inorder)
    end

    it 'returns array of nodes using inorder for an unbalanced tree and only_vals = false' do
      node_unbalanced_tree_inorder = unbalanced_tree_inorder.map { |val| Node.new(val) }
      expect(unbalanced_tree.inorder(only_vals: false)).to eq(node_unbalanced_tree_inorder)
    end
  end

  context '#preorder' do
    balanced_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    balanced_tree_preorder = [4, 2, 1, 3, 6, 5, 7]
    unbalanced_tree = Tree.new([1, 2, 3])
    unbalanced_tree.insert(5)
    unbalanced_tree.insert(7)
    unbalanced_tree_preorder = [2, 1, 3, 5, 7]

    it 'returns array of values in preorder for a balanced tree' do
      expect(balanced_tree.preorder).to eq(balanced_tree_preorder)
    end

    it 'returns array of nodes in preorder for a balanced tree and only_vals = false' do
      node_balanced_tree_preorder = balanced_tree_preorder.map { |val| Node.new(val) }
      expect(balanced_tree.preorder(only_vals: false)).to eq(node_balanced_tree_preorder)
    end

    it 'returns array of values in preorder for an unbalanced tree' do
      expect(unbalanced_tree.preorder).to eq(unbalanced_tree_preorder)
    end

    it 'returns array of nodes in preorder for an unbalanced tree and only_vals = false' do
      node_unbalanced_tree_preorder = unbalanced_tree_preorder.map { |val| Node.new(val) }
      expect(unbalanced_tree.preorder(only_vals: false)).to eq(node_unbalanced_tree_preorder)
    end
  end

  context '#postorder' do
    balanced_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    balanced_tree_postorder = [1, 3, 2, 5, 7, 6, 4]
    unbalanced_tree = Tree.new([1, 2, 3])
    unbalanced_tree.insert(5)
    unbalanced_tree.insert(7)
    unbalanced_tree_postorder = [1, 7, 5, 3, 2]

    it 'returns array of values in postorder for a balanced tree' do
      expect(balanced_tree.postorder).to eq(balanced_tree_postorder)
    end

    it 'returns array of nodes in postorder for a balanced tree and only_vals = false' do
      node_balanced_tree_postorder = balanced_tree_postorder.map { |val| Node.new(val) }
      expect(balanced_tree.postorder(only_vals: false)).to eq(node_balanced_tree_postorder)
    end

    it 'returns array of values in postorder for an unbalanced tree' do
      expect(unbalanced_tree.postorder).to eq(unbalanced_tree_postorder)
    end

    it 'returns array of nodes in postorder for an unbalanced tree and only_vals = false' do
      node_unbalanced_tree_postorder = unbalanced_tree_postorder.map { |val| Node.new(val) }
      expect(unbalanced_tree.postorder(only_vals: false)).to eq(node_unbalanced_tree_postorder)
    end
  end

  context '#find' do
    my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    it 'returns node object if it exists' do
      expect(my_tree.find(7)).to eq(Node.new(7))
    end

    it 'returns nil if no node exists' do
      expect(my_tree.find(8)).to eq(nil)
    end

    it 'returns node after insertion' do
      my_tree2 = Tree.new([1, 2, 3, 4, 5, 6, 7])
      expect(my_tree2.find(8)).to eq(nil)
      my_tree2.insert(8)
      expect(my_tree2.find(8)).to eq(Node.new(8))
    end
  end

  context '#height' do
    my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    it 'returns the height of the root' do
      expect(my_tree.height(my_tree.root)).to eq(2)
    end

    it 'returns zero for a height of a leaf node' do
      expect(my_tree.height(my_tree.find(1))).to eq(0)
    end

    it 'returns height of an intermediate node' do
      expect(my_tree.height(my_tree.find(2))).to eq(1)
    end

    it 'returns the longest path from root' do
      my_tree2 = Tree.new([1, 2, 3])
      my_tree2.insert(4)
      my_tree2.insert(5)
      expect(my_tree2.height(my_tree2.root)).to eq(3)
    end
  end

  context '#depth' do
    my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    my_tree2 = Tree.new([1, 2, 3])
    my_tree2.insert(4)
    my_tree2.insert(5)

    it 'returns the root depth as 0' do
      expect(my_tree.depth(my_tree.root)).to eq(0)
    end

    it 'returns the right depth on a balanced tree' do
      expect(my_tree.depth(my_tree.find(5))).to eq(2)
    end

    it 'returns the right depth on an unbalanced tree' do
      expect(my_tree2.depth(my_tree2.find(5))).to eq(3)
    end
  end

  context '#balanced?' do
    my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    my_tree2 = Tree.new([1, 2, 3])
    my_tree2.insert(4)
    my_tree2.insert(5)

    it 'returns true for a balanced tree' do
      expect(my_tree.balanced?).to eq(true)
    end

    it 'returns false for an unbalanced tree' do
      expect(my_tree2.balanced?).to eq(false)
    end
  end

  context '#rebalance!' do
    my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
    my_tree2 = Tree.new([1, 2, 3])
    my_tree2.insert(4)
    my_tree2.insert(5)

    it 'returns root for a balanced tree' do
      pre_balanced_root = my_tree.root
      expect(my_tree.rebalance!).to eq(pre_balanced_root)
    end

    it 'balances an unbalanced tree' do
      my_tree2.rebalance!
      expect(my_tree2.balanced?).to eq(true)
    end

    it 'returns correct root after balancing tree' do
      new_root = my_tree2.rebalance!
      expect(new_root).to eq(Node.new(3))
    end
  end
end
