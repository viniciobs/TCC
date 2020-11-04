class RenameProductCategoryToProductCategoryId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :products, :product_category, :product_category_id
  end
end
