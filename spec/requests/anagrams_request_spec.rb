require 'rails_helper'

describe 'Anagrams API' do
  it 'returns a JSON array of English-language words that are anagrams of the word passed in the URL' do
    read = Word.create(text: 'read')
    dear = Word.create(text: 'dear')
    Word.create(text: 'dare')
    Word.create(text: 'pizza')

    get "/anagrams/read"
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
  it 'returns empty array for a word with no anagrams' do
    read = Word.create(text: 'read')
    dear = Word.create(text: 'dear')
    pizza = Word.create(text: 'pizza')

    get "/anagrams/#{pizza.text}"
    expect(response).to be_success

    list = JSON.parse(response.body)
    expect(list["anagrams"]).to eq([])
  end
end
