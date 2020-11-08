class SetActiveNotNullAndDefaultFalseToUsers < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :active, :boolean, null: false, default: 0
  end
end
