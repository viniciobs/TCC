class Song < ApplicationRecord
	belongs_to :user
	has_many :rate, dependent: :destroy

	scope :filter_by_author, -> (author) { where("upper(author) like upper(?)", "%#{author}%") }
	scope :filter_by_name, -> (name) { where("upper(name) like upper(?)", "%#{name}%") }
end
