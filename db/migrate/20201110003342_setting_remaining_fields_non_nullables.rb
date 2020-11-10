class SettingRemainingFieldsNonNullables < ActiveRecord::Migration[6.0]
  def change
  	change_column :artist_suggestions, :user_id, :integer, null: false
  	change_column :artist_suggestions, :target_id, :integer, null: false
  end
end
