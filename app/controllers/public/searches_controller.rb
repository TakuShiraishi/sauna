class Public::SearchesController < ApplicationController
  def search_sauna_result
    @saunas = Sauna.looks(params[:prefecture_name] )
    @range = params[:range]
    content = params["name"]
    method = params["method"]
    if method == 'perfect'
      @saunas=@saunas.where(name: content)
    else
      @saunas=@saunas.where('name LIKE ?', '%'+content.to_s+'%')
    end
  end

  def search_user_result
    @users = User.looks(params[:search], params[:name])
    @range = params[:range]
    content = params["name"]
    method = params["method"]
    if method == 'perfect'
      @users=@users.where(name: content)
    else
      @users=@users.where('name LIKE ?', '%'+content+'%')
    end
  end
end