class EditUserField < ActiveRecord::Migration[6.0]
  def change
  	add_index :users, :login, unique: true
  	remove_index :users, name: 'index_users_on_email'
  end
end
