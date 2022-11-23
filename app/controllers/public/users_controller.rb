class Public::UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:update,:edit]
 before_action :ensure_guest_user, only: [:edit]
 def index
  @users = User.where.not(is_deleted: true)
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
 	  redirect_to user_path(@user), notice: "You have updated user successfully."
  else
 		render :edit
  end
 end

 def unsubscribe
  @user = current_user
 end

 def withdraw
  @user = current_user
  @user.update(is_deleted: true)
  # is_deletedをtrue削除フラグ
  reset_session
  redirect_to root_path, notice: "退会しました"
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

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end