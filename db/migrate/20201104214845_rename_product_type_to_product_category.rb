class RenameProductTypeToProductCategory < ActiveRecord::Migration[6.0]
  def change
  	rename_column :products, :product_type, :product_category
  end
end
