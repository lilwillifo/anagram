# Word class for words table. Has a text attribute and belongs to an anagram key that is the word alphabetized by characters
#
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Word < ApplicationRecord
  # the anagram it belongs to is an object with a key of sorted characters.
  belongs_to :anagram

  # Pulls together data on the entire word store.
  # @return [JSON] count, min, max, median, and average

  # length of a word
  def length
    text.length
  end

  def self.analytics
    {"count": count,
      "word_length":
        {"min": min,
         "max": max,
         "median": median,
         "average": average}
    }
  end

  private

  # finds the minimum word length
  def self.min
    minimum(:text).length
  end

  # finds the maximum word length
  def self.max
    maximum(:text).length
  end

  # finds the median word length by ordering text length and finding halfway value
  def self.median
  end

  # finds average word length
  def self.average
  end
end
