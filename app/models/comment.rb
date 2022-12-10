class Comment < ApplicationRecord
	 belongs_to :user
	 belongs_to :sauna
	 has_many :comment_favorites, dependent: :destroy
	 
	 validates :comment,presence:true,length:{maximum:200}

	def favorited_by?(user)
	  comment_favorites.exists?(user_id: user.id)
	end

end
