class Public::UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_guest_user, only: [:edit]
 def index
  @users = User.all
 end

 def show
	@user = User.new
	@user = User.find(params[:id])
 end

 def edit
	@user = User.find(params[:id])
 end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
 	  redirect_to user_path(@user)
  else
 		render :edit
  end
 end

 def favorites
  @user = User.find(params[:id])
  favorites = Favorite.where(user_id: @user.id).pluck(:sauna_id)
  # Product.pluck(:name)productモデルのnameカラムの一覧を持ってこれる
 # favoritesの中身には、何が入ってるかというと、あるユーザーがいいねした記事のid
  @favorite_saunas = Sauna.find(favorites)
 end

 private

  def user_params
	 params.require(:user).permit(:name,:birth_date,:gender,:profile_image)
  end


  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end