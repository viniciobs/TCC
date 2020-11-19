class SetDefaultToTrue < ActiveRecord::Migration[6.0]
  def change
  	change_column :order_items, :can_cancel, :boolean, null: false, default: true
  end
end
