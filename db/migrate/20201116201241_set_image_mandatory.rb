class SetImageMandatory < ActiveRecord::Migration[6.0]
  def change
  	change_column :products, :image, :string, null: false
  end
end
