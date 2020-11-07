class RemoveColumnsFromUser < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users, :email, :string
  	remove_column :users, :image, :string
  end
end
