class Public::CommentFavoritesController < ApplicationController
 def create
 #byebug
   @comment = Comment.find(params[:comment_id])
   @sauna = Sauna.find(params[:sauna_id])
   comment_favorite = current_user.comment_favorites.new(comment_id: @comment.id)
   comment_favorite.save
 end

  def destroy
  
   @comment = Comment.find(params[:comment_id])
   @sauna = Sauna.find(params[:sauna_id])
   comment_favorite = current_user.comment_favorites.find_by(comment_id: @comment.id)
   comment_favorite.destroy
  end

end