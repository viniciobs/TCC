class SetDefaultValueToUsersUserType < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :user_type, :integer, null: false, default: 2
  end
end
