class CreateArtistSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_suggestions do |t|
      t.string :text
      t.integer :user_id
      t.integer :target_id

      t.timestamps
    end
  end
end
