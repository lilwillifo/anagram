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
  describe 'class methods' do
    context 'analytics' do
      it 'returns count, min, max, median, and avg word length' do
        anagram_1 = Anagram.create(key: 'aipzz')
        anagram_2 = Anagram.create(key: 'beorst')
        anagram_3 = Anagram.create(key: 'ader')
        anagram_1.words.create(text: 'pizza')
        anagram_2.words.create(text: 'sorbet')
        anagram_3.words.create(text: 'read')
        anagram_3.words.create(text: 'dear')
        anagram_3.words.create(text: 'dare')

        expect(Word.analytics[:count]).to eq(5)
        expect(Word.analytics[:word_length][:min]).to eq(4)
        expect(Word.analytics[:word_length][:max]).to eq(6)
        expect(Word.analytics[:word_length][:median]).to eq(4)
        expect(Word.analytics[:word_length][:average]).to eq(4.6)
      end
    end
  end
end
