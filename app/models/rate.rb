class Rate < ApplicationRecord
	belongs_to :user
	has_one :song	
end
