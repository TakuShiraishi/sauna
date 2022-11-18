class Admin::SaunasController < ApplicationController

 def index
 	@user = current_user
 	@saunas = Sauna.all.eager_load(:user).preload(:comments,:favorites)
 	# N+1問題のためeager_load(:user).preload(:comments)処理時間の削減
 	@sauna = Sauna.new
 end

 def show
  @sauna = Sauna.find(params[:id])
  @saunas = Sauna.all
  @comment = Comment.new
 end

 def destroy
  sauna = Sauna.find(params[:id])
  sauna.destroy
  redirect_to admin_saunas_path
 end

 def sauna_params
   params.require(:sauna).permit(:profile_image, :prefecrure, :name,:temperature,:place,:holiday,:prefecture,:post_code,:address,:price,:time,:comment,:star)
 end
end
