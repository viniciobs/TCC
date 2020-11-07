class SettingNonNullableUserName < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :name, :string, null: false
  end
end
