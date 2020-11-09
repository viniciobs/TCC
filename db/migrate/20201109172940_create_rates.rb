class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.integer :song_id, null: false
      t.integer :user_id, null: false
      t.decimal :value, null: false

      t.timestamps
    end
  end
end
