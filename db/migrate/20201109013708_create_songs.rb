class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :author, null: false
      t.string :name, null: false
      t.integer :user, null: false

      t.timestamps
    end
  end
end
