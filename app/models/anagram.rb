# Holds keys for sorted words, has many words.
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Anagram < ApplicationRecord
  validates_presence_of :key
  validates_uniqueness_of :key
  has_many :words
end
