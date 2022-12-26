class Public::SaunasController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]

  def new
    @saunas = Sauna.all
    @sauna = Sauna.new
  end

  def index
    @user = current_user
    @saunas = Sauna.eager_load(:user).preload(:comments,:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size }
    @saunas = Kaminari.paginate_array(@saunas).page(params[:page]).per(6)
    # N+1問題のためeager_load(:user).preload(:comments)処理時間の削減
    @sauna = Sauna.new
  end

  def show_index_sauna
    @user = User.find(params[:sauna_id])
    @saunas = @user.saunas
    @comment = Comment.new
  end

  def create
    @sauna = Sauna.new(sauna_params)
    @sauna.score = Language.get_data(sauna_params[:comment])  #この行を追加
    @sauna.user_id = current_user.id
    if @sauna.save
      redirect_to saunas_path(@sauna.id)
      flash[:notice] = "サウナの投稿ができました"
    else
      @user = current_user
      @saunas = Sauna.page(params[:page]).eager_load(:user).preload(:comments,:favorites)
      render :new
    end
  end

  def show
    @sauna = Sauna.find(params[:id])
    @saunas = Sauna.all
    @comment = Comment.new
    gon.sauna = @sauna
  end

  def edit
    @sauna = Sauna.find(params[:id])
  end

  def destroy
    sauna = Sauna.find(params[:id])
    sauna.destroy
    redirect_to '/saunas'
    flash[:notice] = "サウナの投稿を削除しました"
  end

  def update
    @sauna = Sauna.find(params[:id])
    @sauna.score = Language.get_data(sauna_params[:comment])  #この行を追加
    @sauna.save
    if @sauna.update(sauna_params)
      redirect_to sauna_path(@sauna.id), notice: "サウナ投稿を更新しました"
    else
      render :edit
    end
  end

  private

  def sauna_params
    params.require(:sauna).permit(:profile_image,:name,:temperature,:place,:holiday,:prefecture,:post_code,:address,:price,:time,:comment,:star)
  end

  def ensure_correct_user
    @sauna = Sauna.find(params[:id])
    redirect_to saunas_path unless @sauna.user == current_user
  end
end