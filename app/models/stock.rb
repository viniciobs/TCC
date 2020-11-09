class Stock < ApplicationRecord
	has_one :product, dependent: :delete

	scope :filter_by_min_quantity, -> (min_quantity) { where("quantity >= ?", min_quantity.to_i) }
	scope :filter_by_max_quantity, -> (max_quantity) { where("quantity <= ?", max_quantity.to_i) }

end
