class Admin::SaunasController < ApplicationController
  def index
    @user = current_user
    @saunas = Sauna.eager_load(:user).page(params[:page]).order('score DESC')
    # sort {|a,b| b.score <=> a.score }
    # N+1問題のためeager_load(:user).preload(:comments)処理時間の削減,感情分析並び替え
    @sauna = Sauna.new
  end

  def show
    @sauna = Sauna.find(params[:id])
    @saunas = Sauna.all
    @comment = Comment.new
    gon.sauna = @sauna
  end

  def show_index_sauna
    @user = User.find(params[:sauna_id])
    @saunas = @user.saunas
    @comment = Comment.new
  end

  def destroy
    sauna = Sauna.find(params[:id])
    sauna.destroy
    redirect_to admin_saunas_path
    flash[:notice] = "サウナの投稿を削除しました"
  end

  def sauna_params
    params.require(:sauna).permit(:profile_image, :prefecrure, :name,:temperature,:place,:holiday,:prefecture,:post_code,:address,:price,:time,:comment,:star)
  end

  def ensure_correct_user
    @sauna = Sauna.find(params[:id])
    redirect_to saunas_path unless @sauna.user == current_user
  end
end
