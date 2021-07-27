require 'spec_helper'
require_relative '../substrings.rb'

RSpec.describe 'Subsrting Project Specifications' do
    describe 'The Odin Project example' do
        let(:dictonary) { ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] }
        
        it 'works with one word in the first argument' do
            expected_output = {"below" => 1, "low" => 1}
            expect(substrings("below"), dictionary).to_eq(expected_output)
        end

        it 'works with multiple words in the first argument' do
            expected_output = { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
            expect(substrings("Howdy partner, sit down! How's it going?", dictionary)).to_eq(expected_output)
        end
    end

    describe 'Personal test case' do
        it 'works with repeated word' do
            expect(substrings("hi hi hi hi", ["hi"])).to_eq({"hi" => 4})
        end

        it 'works on repeatd words regardless of puncuation' do
            expect(substrings("hi!hi.hi?hi", ["hi"])).to_eq({"hi" => 4})
        end

        it 'returns empty hash when no matches found' do
            expect(substrings("Hello", ["Goodbye"])).to_eq({})
        end

        it 'returns empty hash when dictionary is empty' do
            expect(substrings("Hello", [])).to_eq({})
        end

        it 'returns empty hash when input string is empty' do
            expect(substrings('', ['This', 'is', 'a', 'triumph!'])).to_eq({})
        end

    end

end