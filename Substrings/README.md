# Substrings Project

## Specifications

The substrings method takes in a string and a dictionary (an array of words) and returns a hash of the frequency of each word in the given string. For instance, passing in `"No, I know"` and `["no"]` yields the hash `{"no" => 2}` (Once for the "No" at the start and another for the "no" in "know").

For a full description of what the specifications of this project were, [click here](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/sub-strings).

## Important Take-aways

For this project, I wanted to practice Test Driven Development, so I actually wrote the spec file first, before starting a solution. It was very helpfl to consider what the edge cases were and what I wanted my method to return in those cases. Having written the tests beforehand helped me to identify bugs or other features of my code (like case insensitivity) that I probably would've otherwise missed.