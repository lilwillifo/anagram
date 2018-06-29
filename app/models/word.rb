class Word < ApplicationRecord
  def anagrams
    (all_anagrams[formatted_word] - [text]).sort rescue []
  end

  def formatted_word
    text.downcase.chars.sort.join
  end
  private

  def all_anagrams
    all_anagrams = {}
    Word.all.each do |word|
      if all_anagrams[word.formatted_word]
        all_anagrams[word.formatted_word] << word.text
      else
        all_anagrams[word.formatted_word] = [word.text]
      end
    end
    @all_anagrams ||= all_anagrams
  end


end
