class AdequandoAoRollBack < ActiveRecord::Migration[6.0]
  def change  	
  	rename_column :users, :access_name, :username  	
  	add_index :users, :username, unique: true
  end
end
