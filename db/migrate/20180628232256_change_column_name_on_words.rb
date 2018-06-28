class ChangeColumnNameOnWords < ActiveRecord::Migration[5.1]
  def change
    rename_column :words, :word, :text
  end
end
