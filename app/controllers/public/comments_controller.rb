class Public::CommentsController < ApplicationController
 def index
   @comment = Comment.new
   @sauna = Sauna.find(params[:sauna_id])
   @comments = @sauna.comments.all
 end

 def new
   @comment = Comment.new
   @sauna = Sauna.find(params[:sauna_id])
 end

 def create
		sauna = Sauna.find(params[:sauna_id])
		comment = current_user.comments.new(comment_params)
		comment.sauna_id = sauna.id
   if comment.save!
  		redirect_to sauna_comments_path(sauna)
  		flash[:notice] = "コメントしました"
   else
		  render:new
   end
 end

  def destroy
  	Comment.find(params[:id]).destroy
  	redirect_to sauna_path(params[:sauna_id])
  end

  private

  def comment_params
  	params.require(:comment).permit(:comment)
  end
end
