class SettingNonNullabelText < ActiveRecord::Migration[6.0]
  def change
  	change_column :artist_suggestions, :text, :string, null: false
  end
end
