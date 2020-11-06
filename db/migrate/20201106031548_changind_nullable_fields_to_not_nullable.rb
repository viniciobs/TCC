class ChangindNullableFieldsToNotNullable < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :email, :string, null: true
  	change_column :users, :login, :string, null: false, unique: true
  	change_column :users, :user_type, :integer, null: false
  end
end
