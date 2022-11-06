class Public::SaunasController < ApplicationController
 def new
		@saunas = Sauna.all
		@sauna = Sauna.new
 end

 def index
 	@user = current_user
 	@saunas = Sauna.all
 	@sauna = Sauna.new
 end

 def create
  @sauna = Sauna.new(sauna_params)
  @sauna.user_id = current_user.id
  if @sauna.save
   redirect_to sauna_path(@sauna.id)
  else
   @user = current_user
   @saunas = Sauna.all
   render :index
  end
 end

 def show
  @sauna = Sauna.find(params[:id])
  @user = @sauna.user
 end


 private
 def sauna_params
  params.require(:sauna).permit(:profile_image, :prefecrure, :name,:temperature,:place,:holiday,:prefecture,:post_code,:address,:price,:time)
 end
end


