class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy

	scope :filter_by_user_name, -> (name) { where("upper(name) like upper(?)", "%#{name}%") }
	scope :filter_by_table_num, -> (table_num) { where table_num: table_num }
end
