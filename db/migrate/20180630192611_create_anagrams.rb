class CreateAnagrams < ActiveRecord::Migration[5.1]
  def change
    create_table :anagrams do |t|
      t.string :key
      t.text :words, array: true, default: []
    end
  end
end
