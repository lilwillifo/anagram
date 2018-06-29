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
end
