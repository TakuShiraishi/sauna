class Review < ApplicationRecord
	belongs_to :sauna
	belongs_to :user
	has_one_attached :image
end
