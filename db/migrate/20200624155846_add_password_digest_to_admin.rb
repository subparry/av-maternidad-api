class AddPasswordDigestToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :password_digest, :text
  end
end
