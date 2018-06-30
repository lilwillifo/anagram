require 'rails_helper'

describe Word, type: :model do
  describe 'relationships' do
    it { should belong_to(:anagram) }
  end
end
