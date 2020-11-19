class AddIsDoneToOrderItems < ActiveRecord::Migration[6.0]
  def change
  	add_column :order_items, :is_done, :boolean, default: false
  end
end
