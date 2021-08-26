# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/board_slot'
require_relative '../lib/value_error'
require_relative '../lib/occupied_slot_error'

RSpec.describe BoardSlot do
  let(:slot) { BoardSlot.new('A1') }

  describe '#initialize' do
    it 'creates a free slot' do
      expect(slot.free).to be true
    end

    it 'assigns default fill_char to be "_"' do
      expect(slot.fill_char).to be '_'
    end

    it 'assigns location corectly' do
      expect(slot.location).to be 'A1'
    end
  end

  describe '#mark' do
    it 'changes the fill_char' do
      slot.mark('X')
      expect(slot.fill_char).to be 'X'
    end

    it 'changes the value of free' do
      slot.mark('O')
      expect(slot.free).to be false
    end

    context 'trying to mark again' do
      it 'rasies OccupiedSlotError' do
        slot.mark('X')
        expect { slot.mark('O') }.to raise_error(proc { OccupiedSlotError.new(slot.location) })
      end
    end
  end

  describe '#fill_char=' do
    let(:val_err) { ValueError.new('fill_char must be of length 1 and not "_"') }
    context 'given a single character string' do
      it 'assigns "X" successfully' do
        slot.fill_char = 'X'
        expect(slot.fill_char).to be 'X'
      end

      it 'assigns "O" successfully' do
        slot.fill_char = 'O'
        expect(slot.fill_char).to be 'O'
      end

      it 'raises ValueError for "_"' do
        expect { slot.fill_char = '_' }.to raise_error(proc { val_err })
      end
    end

    context 'given strings of differing lengths' do
      it 'rasies ValueError for empty string' do
        expect { slot.fill_char = '' }.to raise_error(proc { val_err })
      end

      it 'rases ValueError for "XO"' do
        expect { slot.fill_char = 'XO' }.to raise_error(proc { val_err })
      end
    end

    context 'given non-string values' do
      it 'raises ValueError for Array' do
        expect { slot.fill_char = ['A'] }.to raise_error(proc { val_err })
      end

      it 'raises ValueError for Hash' do
        expect { slot.fill_char = { A: 'A' } }.to raise_error(proc { val_err })
      end

      it 'raises ValueError for Integer' do
        expect { slot.fill_char = 1 }.to raise_error(proc { val_err })
      end
    end
  end

  describe '#clear' do
    it 'changes fill_char back to "_"' do
      slot.mark('X')
      expect(slot.free).to be false
      slot.clear
      expect(slot.fill_char).to be '_'
    end

    it 'changes free to true' do
      slot.mark('X')
      expect(slot.free).to be false
      slot.clear
      expect(slot.free).to be true
    end
  end

  describe '#to_s' do
    context 'unmarked' do
      it 'returns the default fill_char' do
        expect(slot.to_s).to be slot.fill_char
      end
    end

    context 'marked' do
      it 'returns the marked_char (X)' do
        slot.mark('X')
        expect(slot.to_s).to be 'X'
      end

      it 'returns the marked char (O)' do
        slot.mark('O')
        expect(slot.to_s).to be 'O'
      end
    end
  end
end
