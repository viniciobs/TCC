class InerirIndexAoTeste < ActiveRecord::Migration[6.0]
  def change
  	add_index :users, :teste, unique: true
  	remove_index :users, name: 'index_users_on_user_name'
  end
end
