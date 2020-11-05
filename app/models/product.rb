class Product < ApplicationRecord
	belongs_to :product_category
	has_one :stock, dependent: :delete
end
