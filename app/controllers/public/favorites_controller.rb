class Public::FavoritesController < ApplicationController
 def create
   @sauna = Sauna.find(params[:sauna_id])
   favorite = current_user.favorites.new(sauna_id: @sauna.id)
   favorite.save
 end

  def destroy
   @sauna = Sauna.find(params[:sauna_id])
   favorite = current_user.favorites.find_by(sauna_id: @sauna.id)
   favorite.destroy
  end

end