class Stock < ApplicationRecord
	has_one :product, dependent: :delete
end
