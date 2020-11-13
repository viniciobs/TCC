class AlterColumnEmailSetNonNullable < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :email, :string, null: false
  end
end
