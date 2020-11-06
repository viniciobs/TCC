class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login, :string
    add_column :users, :user_type, :integer
  end
end
