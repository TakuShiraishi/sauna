class Comment < ApplicationRecord
	 belongs_to :user
	 belongs_to :sauna
	has_one_attached :image
end
