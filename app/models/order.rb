class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy
	
	scope :filter_by_table_num, -> (table_num) { where table_num: table_num }

	def get_total
		total = 0

		self.order_items.each do |item|
			product = Product.find(item.product_id)
			total += item.quantity * product.price
		end

		return total
	end
end
