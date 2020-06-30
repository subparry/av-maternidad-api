class AddBodyToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :body, :text
  end
end
