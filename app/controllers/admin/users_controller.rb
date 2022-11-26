class Admin::UsersController < ApplicationController

 def index
  @users = User.where.not(is_deleted: true)
  # 削除されていたら表示されない
  @users = @users.page(params[:page])
 end

 def show
 	@user = User.new
 	@user = User.find(params[:id])
 end

 def unsubscribe
  @user = User.find(params[:user_id])
 end

 def withdraw
  # byebug
  @user = User.find(params[:user_id])
  @user.is_deleted = true
  @user.save(:validate => false)
  # バリデーションがかかっていたため上の記述
  # is_deletedをtrue削除フラグ
  redirect_to admin_users_path
 end

 private

 def user_params
	 params.require(:user).permit(:name,:birth_date,:gender,:profile_image,:email,:is_deleted)
 end

end
