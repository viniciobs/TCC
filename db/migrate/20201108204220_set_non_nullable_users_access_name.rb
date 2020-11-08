class SetNonNullableUsersAccessName < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :access_name, :string, null: false
  	add_index :users, :access_name, unique: true
  end
end
