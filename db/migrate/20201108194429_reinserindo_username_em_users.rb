class ReinserindoUsernameEmUsers < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users, :username, :string
  	add_column :users, :user_name, :string
  end
end
