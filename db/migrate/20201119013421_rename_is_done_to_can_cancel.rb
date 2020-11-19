class RenameIsDoneToCanCancel < ActiveRecord::Migration[6.0]
  def change
  	rename_column :order_items, :is_done, :can_cancel
  end
end
