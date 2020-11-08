class SetNonNullableUsersAccessName < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :access_name, :string, null: true  	
  end
end
