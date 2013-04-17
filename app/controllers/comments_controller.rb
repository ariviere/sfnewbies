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
  
  def destroy
    @place = Place.find(params[:place_id])
    @comment = Comment.find(params[:id])
    
    if(current_user == @comment.user || current_user.try(:admin?))
      @comment.destroy
    
      respond_to do |format|
        format.html { redirect_to place_path(@place) }
        format.xml  { head :ok }
      end
    
    else
      redirect_to place_path(@place), flash: { :error => "Vous n'avez pas l'autorisation d'effectuer cette action"}
    end
    
  end
end
