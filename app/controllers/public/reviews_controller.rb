class Public::ReviewsController < ApplicationController

 def index
	@sauna = Sauna.find(params[:sauna_id])
	@reviews = @sauna.reviews
 end



  private

end
