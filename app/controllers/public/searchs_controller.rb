class Public::SearchsController < ApplicationController
  # def serch_result
  def  search_result
    @saunas = Sauna.all
		@sauna = Sauna.new
    @saunas = Sauna.looks(params[:prefecture_name] )
  end
end