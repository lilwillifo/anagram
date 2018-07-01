# Word class for words table. Has a text attribute and belongs to an anagram key that is the word alphabetized by characters
#
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Word < ApplicationRecord
  # the anagram it belongs to is an object with a key of sorted characters.
  belongs_to :anagram
end
