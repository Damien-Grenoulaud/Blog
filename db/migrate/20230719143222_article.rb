class Article < ActiveRecord::Migration[7.0]
  def change
    add_reference(:articles, :users, polymorphic: true, index: true)
  end
end
