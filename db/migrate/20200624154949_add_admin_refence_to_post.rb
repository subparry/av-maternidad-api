class AddAdminRefenceToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :admin, foreign_key: true
  end
end
