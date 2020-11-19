class OrderItem < ApplicationRecord
	belongs_to :order
	has_one :product

	enum status: { can_cancel: 0, preparing: 1, done: 2 }
end
