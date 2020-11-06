class ChangeLoginToUsername < ActiveRecord::Migration[6.0]
  def change
  	rename_column :users, :login, :username
  end
end
