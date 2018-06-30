require 'rails_helper'

describe Anagram, type: :model do
  describe 'attributes' do
    it 'has a key and is valid with no words' do
      anagram = Anagram.create(key: 'ader')

      expect(anagram.key).to eq('ader')
    end
    it 'is invalid without a key' do
      anagram = Anagram.create(key: nil)

      expect(anagram.save).to eq(false)
    end
    it 'has a list of words' do
      anagram = Anagram.create(key: 'ader')
      anagram.words = ["read", "dear", "dare"]
      anagram.save
      expect(anagram.words).to eq(["read", "dear", "dare"])
    end
  end
end
