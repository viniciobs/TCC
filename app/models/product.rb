class Product < ApplicationRecord
	belongs_to :product_category
	has_one :stock, dependent: :delete

	scope :filter_by_category, -> (category) { where product_category_id: category }
	scope :filter_by_name, -> (name) { where("name like ?", "%#{name}%") }
end
