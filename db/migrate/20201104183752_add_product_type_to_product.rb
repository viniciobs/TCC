class AddProductTypeToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_type, :integer
  end
end
