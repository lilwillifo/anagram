require 'rails_helper'

describe 'Anagrams API' do
  it 'posts word(s) to database' do
    params = { "words": ["read", "dear", "dare"] }
    post '/words', params: params

    expect(response).to be_success
    expect(Word.count).to eq(params[:words].count)
  end
  it 'can delete a word and returns 204 status code' do
    pizza = Word.create(text: 'pizza')
    sorbet = Word.create(text: 'sorbet')

    expect(Word.count).to eq(2)

    delete "/words/#{pizza.text}"

    expect(response.status).to eq(204)
    expect(Word.count).to eq(1)
  end
  it 'can delete all words and returns 204' do
    pizza = Word.create(text: 'pizza')
    sorbet = Word.create(text: 'sorbet')

    expect(Word.count).to eq(2)

    delete "/words"

    expect(response.status).to eq(204)
    expect(Word.count).to eq(0)
  end
  it 'returns a JSON array of English-language words that are anagrams of the word passed in the URL' do
    read = Word.create(text: 'read')
    dear = Word.create(text: 'dear')
    Word.create(text: 'dare')
    Word.create(text: 'pizza')

    get "/anagrams/#{read.text}"
    expect(response).to be_success

    list = JSON.parse(response.body)
    expect(list["anagrams"].count).to eq(read.anagrams.count)
    expect(list["anagrams"]).to eq(['dare','dear'])

    get "/anagrams/#{read.text}?limit=1"
    expect(response).to be_success

    list = JSON.parse(response.body)
    expect(list["anagrams"].count).to eq(1)
    expect(list["anagrams"]).to eq(['dare'])

  end
end
