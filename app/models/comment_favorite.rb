class CommentFavorite < ApplicationRecord
	belongs_to :comment
   belongs_to :user

   # def favorited_by?(comment_favorite)
   # favorites.exists?(comment_id: comment.id)
   # end
end
