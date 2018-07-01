require 'rails_helper'

describe 'Words API' do
  it 'posts word(s) to database' do
    params = { "words": ["read", "dear", "dare"] }
    post '/words', params: params

    expect(response).to be_success
    expect(Word.count).to eq(params[:words].count)
  end
  it 'can delete a word and returns 204 status code' do
    anagram_1 = Anagram.create(key: 'aipzz')
    anagram_2 = Anagram.create(key: 'beorst')
    pizza = anagram_1.words.create(text: 'pizza')
    sorbet = anagram_2.words.create(text: 'sorbet')

    expect(Word.count).to eq(2)

    delete "/words/#{pizza.text}"

    expect(response.status).to eq(204)
    expect(Word.count).to eq(1)
  end
  it 'cannot delete a word that does not exist' do
    delete "/words/notaword"
    expect(response.status).to eq(404)
  end
  it 'can delete all words and returns 204' do
    anagram_1 = Anagram.create(key: 'aipzz')
    anagram_2 = Anagram.create(key: 'beorst')
    pizza = anagram_1.words.create(text: 'pizza')
    sorbet = anagram_2.words.create(text: 'sorbet')

    expect(Word.count).to eq(2)

    delete "/words"

    expect(response.status).to eq(204)
    expect(Word.count).to eq(0)
  end
  it 'can delete all words multiple times' do
    anagram_1 = Anagram.create(key: 'aipzz')
    anagram_2 = Anagram.create(key: 'beorst')
    pizza = anagram_1.words.create(text: 'pizza')
    sorbet = anagram_2.words.create(text: 'sorbet')

    expect(Word.count).to eq(2)

    delete "/words"
    delete "/words"

    expect(response.status).to eq(204)
    expect(Word.count).to eq(0)

    delete "/words"
    expect(response.status).to eq(204)
    expect(Word.count).to eq(0)
  end
end
