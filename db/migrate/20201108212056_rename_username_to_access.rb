class RenameUsernameToAccess < ActiveRecord::Migration[6.0]
  def change
  	remove_index :users, name: 'index_users_on_username'
  	rename_column :users, :username, :access  	
  	add_index :users, :access, unique: true
  end
end
