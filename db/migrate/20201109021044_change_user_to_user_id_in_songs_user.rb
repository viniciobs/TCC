class ChangeUserToUserIdInSongsUser < ActiveRecord::Migration[6.0]
  def change
  	rename_column :songs, :user, :user_id
  end
end
