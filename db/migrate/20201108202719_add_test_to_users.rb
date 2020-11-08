class AddTestToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :teste, :string
  end
end
