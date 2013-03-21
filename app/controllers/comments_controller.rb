class CommentsController < ApplicationController
  
  def create
    @place = Place.find(params[:place_id])
    @comment = Comment.new(params[:comment])
    @comment.place = @place
    @comment.user = current_user
    
    if @comment.save
       flash[:success] = "Comment created!"
       redirect_to @place
    else
      render 'shared/_comment_form'
    end
  end
end
