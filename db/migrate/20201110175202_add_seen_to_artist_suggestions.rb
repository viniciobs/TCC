class AddSeenToArtistSuggestions < ActiveRecord::Migration[6.0]
  def change
    add_column :artist_suggestions, :seen, :boolean, null: false, default: 0
  end
end
