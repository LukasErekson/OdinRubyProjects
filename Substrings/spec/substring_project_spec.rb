require 'spec_helper'
require_relative '../substrings.rb'

RSpec.describe 'Subsrting Project Specifications' do
    describe 'The Odin Project example' do
        let(:dictionary) { ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] }
        
        it 'works with one word in the first argument' do
            expected_output = {"below" => 1, "low" => 1}
            expect(substrings("below", dictionary)).to eq(expected_output)
        end

        it 'works with multiple words in the first argument' do
            expected_output = { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
            expect(substrings("Howdy partner, sit down! How's it going?", dictionary)).to eq(expected_output)
        end
    end

    describe 'Personal test case' do

        context 'repeated words' do
            it 'works with repeated word' do
                expect(substrings("hi hi hi hi", ["hi"])).to eq({"hi" => 4})
            end

            it 'works on repeated words regardless of puncuation' do
                expect(substrings("hi!hi.hi?hi", ["hi"])).to eq({"hi" => 4})
            end
        end

        context 'case insensitive' do
            it 'case insensitive to the input string' do
                expect(substrings("HeLlO!?", ["hello"])).to eq ({"hello" => 1})
            end
    
            it 'case insensitive to the dictionary' do
                expect(substrings("hello!?", ["HeLlO"])).to eq ({"hello" => 1})
            end
        end

        context 'edge case' do
            it 'returns empty hash when no matches found' do
                expect(substrings("Hello", ["Goodbye"])).to eq({})
            end
    
            it 'returns empty hash when dictionary is empty' do
                expect(substrings("Hello", [])).to eq({})
            end
    
            it 'returns empty hash when input string is empty' do
                expect(substrings('', ['This', 'is', 'a', 'triumph!'])).to eq({})
            end
        end

    end

end