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
  end
  context 'relationships' do
    it {should have_many :words}
  end
end
