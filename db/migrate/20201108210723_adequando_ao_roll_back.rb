class AdequandoAoRollBack < ActiveRecord::Migration[6.0]
  def change
  	remove_index :users, name: 'index_users_on_access_name'
  	rename_column :users, :access_name, :username  	
  	add_index :users, :username, unique: true
  end
end
