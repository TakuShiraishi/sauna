class Public::FavoritesController < ApplicationController
  def create
    @sauna = Sauna.find(params[:sauna_id])
    favorite = current_user.favorites.new(sauna_id: @sauna.id)
    #  @comment = Comment.find(params[:comment_id])
    # favorite = current_user.favorites.new(comment_id: @comment.id)
    favorite.save
  end

  def destroy
    #byebug
    @sauna = Sauna.find(params[:sauna_id])
    favorite = current_user.favorites.find_by(sauna_id: @sauna.id)
    # @comment = Comment.find(params[:comment_id])
    # favorite = current_user.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  end
end