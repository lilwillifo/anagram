# Word class for words table. Has a text attribute and belongs to an anagram key that is the word alphabetized by characters
#
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Word < ApplicationRecord
  belongs_to :anagram
end
