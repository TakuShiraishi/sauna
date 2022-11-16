class Admin::UsersController < ApplicationController

 def index
  @users = User.where.not(is_deleted: true)
  # 削除されていたら表示されない
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
   render :show
  else
   render :edit
  end
 end

 def unsubscribe
  @user = User.find(params[:user_id])
 end

 def withdraw
  if current_user
   @user = current_user
  else
   @user = User.find(params[:user_id])
  end
  @user.update(is_deleted: true)
  # is_deletedをtrue削除フラグ
  if current_user
   reset_session
   # ユーザーがログインしていて退会したら
  url = root_path
  else
  url = admin_users_path
  end
  redirect_to url
  # root_pathかadmin_users_pathに遷移する
 end

 private

 def user_params
	 params.require(:user).permit(:name,:birth_date,:gender,:profile_image,:email,:is_deleted)
 end

end
