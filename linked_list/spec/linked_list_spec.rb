# frozen_string_literal: true

require_relative '../lib/linked_list'
require_relative '../lib/node'
require_relative '../lib/empty_list_error'

RSpec.describe 'Linked List Unit Tests' do
  context 'Initializing an empty list' do
    empty_list = LinkedList.new
    it '#head returns nil' do
      expect(empty_list.head).to eq(nil)
    end

    it '#tail returns nil' do
      expect(empty_list.tail).to eq(nil)
    end

    it '#size returns 0' do
      expect(empty_list.size).to eq(0)
    end
  end

  context '#append a single value' do
    one_item_list = LinkedList.new
    one_item_list.append(1)
    expected_node = Node.new(1)

    it 'updates size' do
      expect(one_item_list.size).to eq(1)
    end

    it 'updates tail' do
      expect(one_item_list.tail).to eq(expected_node)
    end

    it 'updates head' do
      expect(one_item_list.head).to eq(expected_node)
    end
  end

  context '#append multiple values' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'updates size' do
      expect(many_item_list.size).to eq(5)
    end

    it 'updates tail' do
      expect(many_item_list.tail).to eq(Node.new(5))
    end

    it 'updates head' do
      expect(many_item_list.head).to eq(Node.new(1))
    end

    it '#each works correctly' do
      node_array = []
      many_item_list.each do |node|
        node_array.append(node.value)
      end
      expect(node_array).to eq((1..5).to_a)
    end
  end

  context '#prepend a single value' do
    one_item_list = LinkedList.new
    one_item_list.prepend(1)
    expected_node = Node.new(1)

    it 'updates size' do
      expect(one_item_list.size).to eq(1)
    end

    it 'updates tail' do
      expect(one_item_list.tail).to eq(expected_node)
    end

    it 'updates head' do
      expect(one_item_list.head).to eq(expected_node)
    end
  end

  context '#prepend multiple values' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.prepend(n) }

    it 'updates size' do
      expect(many_item_list.size).to eq(5)
    end

    it 'returns correct tail' do
      expect(many_item_list.tail).to eq(Node.new(1))
    end

    it 'returns correct head' do
      expect(many_item_list.head).to eq(Node.new(5))
    end

    it '#each works correctly' do
      node_array = []
      many_item_list.each do |node|
        node_array.append(node.value)
      end
      expect(node_array).to eq((1..5).to_a.reverse)
    end
  end

  context '#at' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.prepend(n) }

    it 'first index returns head' do
      expect(many_item_list.at(0)).to eq(many_item_list.head)
    end

    it 'last index returns tail' do
      expect(many_item_list.at(4)).to eq(many_item_list.tail)
    end

    it 'positive index reaches the correct node' do
      expect(many_item_list.at(2)).to eq(Node.new(3))
    end

    it 'bracket works as an alias' do
      expect(many_item_list[3]).to eq(Node.new(2))
    end
  end

  context '#pop' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'returns the tail ' do
      expected_output = many_item_list.tail
      expect(many_item_list.pop).to eq(expected_output)
    end

    it 'updates the tail' do
      expect(many_item_list.tail).to eq(Node.new(4))
    end

    it 'popping multiple items returns array' do
      many_item_list = LinkedList.new
      (1..5).each { |n| many_item_list.append(n) }
      expect(many_item_list.pop(3)).to eq([Node.new(5), Node.new(4), Node.new(3)])
    end

    it 'popping more items than the list pops rest of the array' do
      many_item_list = LinkedList.new
      expected_output = []
      (1..5).reverse_each { |n| expected_output.append(Node.new(n)) }
      (1..5).each { |n| many_item_list.append(n) }
      expect(many_item_list.pop(7)).to eq(expected_output)
    end

    it 'raises an error popping an empty list' do
      empty_list = LinkedList.new
      expect { empty_list.pop }.to raise_error { EmptyListError.new('Cannot pop an empty list.') }
    end
  end

  context '#contains?' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'returns true if an item is in the list' do
      expect(many_item_list.contains?(4)).to eq(true)
    end

    it 'returns false if an item is not in the list' do
      expect(many_item_list.contains?(0)).to eq(false)
    end

    it 'returns false if the list is empty' do
      empty_list = LinkedList.new
      expect(empty_list.contains?(4)).to eq(false)
    end
  end

  context '#find' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'finds an element in a list' do
      expect(many_item_list.find(4)).to eq(3)
    end

    it 'returns nil if the element is not in the list' do
      expect(many_item_list.find(-1)).to eq(nil)
    end
  end

  context '#to_s' do
    it 'prints integer list properly' do
      many_item_list = LinkedList.new
      (1..5).each { |n| many_item_list.append(n) }

      expect(many_item_list.to_s).to eq('( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> ( 5 ) -> nil')
    end

    it 'prints string list properly' do
      str_list = LinkedList.new
      'List'.split('').each { |char| str_list.append(char) }
      expect(str_list.to_s).to eq('( L ) -> ( i ) -> ( s ) -> ( t ) -> nil')
    end

    it 'prints mixed value list properly' do
      mixed_list = LinkedList.new
      mixed_list.append('A')
      mixed_list.append(2)
      mixed_list.append(Node.new('meta-Node'))

      expect(mixed_list.to_s).to eq('( A ) -> ( 2 ) -> ( ( meta-Node ) ) -> nil')
    end
  end

  context '#insert_at' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'returns true on successful insertion' do
      expect(many_item_list.insert_at(0, 2)).to eq(true)
    end

    it 'increments size' do
      expect(many_item_list.size).to eq(6)
    end

    it 'inserts the value at the right index' do
      expect(many_item_list.at(2)).to eq(Node.new(0))
    end

    it '#each still works properly' do
      node_array = []
      many_item_list.each do |node|
        node_array.append(node.value)
      end
      expect(node_array).to eq([1, 2, 0, 3, 4, 5])
    end

    it 'raises an error if list is empty' do
      empty_list = LinkedList.new
      expect { empty_list.insert_at(0, 1) }.to raise_error {
                                                 EmptyListError.new('Cannot insert at index 1; the list is empty.')
                                               }
    end

    it 'raises an error for an out-of-bounds index' do
      expect { many_item_list.insert_at(-1, 10) }.to raise_error {
                                                       IndexError.new('10 is out of bounds for list of size 6')
                                                     }
    end

    it 'inserts as head/tail for empty list if index is 0' do
      empty_list = LinkedList.new
      empty_list.insert_at(0, 0)
      expect(empty_list.size).to eq(1)
    end
  end

  context '#remove_at' do
    many_item_list = LinkedList.new
    (1..5).each { |n| many_item_list.append(n) }

    it 'returns node at the given index' do
      expect(many_item_list.remove_at(3)).to eq(Node.new(4))
    end

    it 'decrements size' do
      expect(many_item_list.size).to eq(4)
    end

    it 'removes the right object' do
      expect(many_item_list.at(3)).to eq(Node.new(5))
    end

    it '#each still works properly' do
      node_array = []
      many_item_list.each do |node|
        node_array.append(node.value)
      end
      expect(node_array).to eq([1, 2, 3, 5])
    end

    it 'raises an error if list is empty' do
      empty_list = LinkedList.new
      expect { empty_list.remove_at(1) }.to raise_error {
                                              EmptyListError.new('Cannot remove at index 1; the list is empty.')
                                            }
    end

    it 'raises an error for an out-of-bounds index' do
      expect { many_item_list.remove_at(10) }.to raise_error {
                                                   IndexError.new('10 is out of bounds for list of size 4')
                                                 }
    end

    it 'pops the array when given the last index' do
      many_item_list = LinkedList.new
      (1..5).each { |n| many_item_list.append(n) }
      expect(many_item_list.remove_at(4)).to eq(Node.new(5))
    end
  end
end
