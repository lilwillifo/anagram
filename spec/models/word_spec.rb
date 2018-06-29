require 'rails_helper'

describe Word, type: :model do
  describe 'instance methods' do
    context '.anagrams' do
      it 'returns an array of a words anagrams' do
        read = Word.create(text: 'read')
        Word.create(text: 'dear')
        Word.create(text: 'dare')
        Word.create(text: 'pizza')

        expect(read.anagrams).to eq(['dare', 'dear'])
      end
    end
  end
end
