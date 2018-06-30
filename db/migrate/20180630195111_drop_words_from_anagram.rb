class DropWordsFromAnagram < ActiveRecord::Migration[5.1]
  def change
    remove_column :anagrams, :words
  end
end
