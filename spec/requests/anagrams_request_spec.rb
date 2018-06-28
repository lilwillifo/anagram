require 'rails_helper'

describe 'Anagrams API' do
  it 'posts word(s) to database' do
    params = { "words": ["read", "dear", "dare"] }
    post '/words', params: params

    expect(response).to be_success
    expect(Word.count).to eq(params[:words].count)
  end
end
