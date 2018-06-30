# Word class for words table. Has a text attribute and method to pull a word's anagrams
#
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Word < ApplicationRecord
  belongs_to :anagram
end
