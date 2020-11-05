class RenameProductToProductId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :stocks, :product, :product_id
  end
end
