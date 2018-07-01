require 'rails_helper'

describe Word, type: :model do
  describe 'attributes' do
    it 'has text' do
      anagram = Anagram.create(key: 'ader')
      word = anagram.words.create(text: 'read')

      expect(word.text).to eq('read')
    end
  end
  describe 'relationships' do
    it { should belong_to(:anagram) }
  end
end
