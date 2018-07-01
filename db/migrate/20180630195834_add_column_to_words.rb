class AddColumnToWords < ActiveRecord::Migration[5.1]
  def change
    add_reference :words, :anagram, foreign_key: true
  end
end
