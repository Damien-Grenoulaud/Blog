class Article < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :categorie, :integer, default: 0
  end
end
