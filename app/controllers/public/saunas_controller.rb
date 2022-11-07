class Public::SaunasController < ApplicationController
 before_action :authenticate_user!
 before_action :login_user, only: [ :edit]

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
   redirect_to saunas_path(@sauna.id)
  else
   @user = current_user
   @saunas = Sauna.all
   render :index
  end
 end

 def show
  @sauna = Sauna.find(params[:id])
  @saunas = Sauna.all
  @sauna = Sauna.new
 end

 def edit
  @sauna = Sauna.find(params[:id])
 end

 def destroy
  sauna = Sauna.find(params[:id])
  sauna.destroy
  redirect_to '/saunas'
 end

 def update
  @sauna = Sauna.find(params[:id])
  if @sauna.update(sauna_params)
   redirect_to sauna_path(@sauna.id)
  else
   render :edit
  end
 end

 private

  def sauna_params
   params.require(:sauna).permit(:profile_image, :prefecrure, :name,:temperature,:place,:holiday,:prefecture,:post_code,:address,:price,:time,:comment)
  end

  def login_user
   @sauna = Sauna.find(params[:id])
   redirect_to saunas_path unless @sauna.user == current_user
  end
end


