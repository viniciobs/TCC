class TryToSolveSomeShit < ActiveRecord::Migration[6.0]
  def change
  	remove_index :users, name: 'index_users_on_teste'
  	
  	remove_column :users, :teste, :string
  	remove_column :users, :user_name, :string

	add_column :users, :access_name, :string	
  end
end
