class RenameColumn < ActiveRecord::Migration[6.0]
  def change  	
  	remove_column :order_items, :can_cancel
  	add_column :order_items, :status, :integer, null: false, default: 0  		
  end
end
