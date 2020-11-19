class AddTimeStampsToOrderItems < ActiveRecord::Migration[6.0]
  def change
  	add_column :order_items, :created_at, :datetime, null: false
    add_column :order_items, :updated_at, :datetime, null: false
  end
end
