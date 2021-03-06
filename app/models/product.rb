class Product < ApplicationRecord
	belongs_to :product_category
	has_one :stock, dependent: :delete

	scope :filter_by_category, -> (category) { where product_category_id: category }
	scope :filter_by_name, -> (name) { where("upper(name) like upper(?)", "%#{name}%") }

	def has_order_associated 
      return OrderItem.where(product_id: self.id).any?
    end
end
