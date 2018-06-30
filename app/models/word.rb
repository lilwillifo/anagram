# Word class for words table. Has a text attribute and method to pull a word's anagrams
#
# @author Margaret Williford
# @abstract
# @attr [String] text: The string of the word
class Word < ApplicationRecord
  # Finds all anagrams in the database for a word instance.
  #
  # @return [Array] all words (string of the word, not an instance)
  def anagrams
    (all_anagrams[formatted_word] - [text]).sort rescue []
  end

  # Formats the text to downcase and alphabetize characters
  #
  # @return [String] word -> dorw Test -> estt
  def formatted_word
    text.downcase.chars.sort.join
  end
  private

  def build_anagrams
    all_anagrams = {}
    Word.all.each do |word|
      if all_anagrams[word.formatted_word]
        all_anagrams[word.formatted_word] << word.text
      else
        all_anagrams[word.formatted_word] = [word.text]
      end
    end
    all_anagrams
  end

  def all_anagrams
    @all_anagrams ||= build_anagrams
  end

end
