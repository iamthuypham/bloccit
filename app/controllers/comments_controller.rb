class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  def show
    @comment = Comment.find(params[:id])
  end
  def new
  end
  
  def create
    id = params[:post_id] || params[:topic_id]
    if params[:post_id]
      @parent = Post.find(id)

    elsif params[:topic_id]
      @parent = Topic.find(id)
        
    end
    @comment = @parent.comments.new(comment_params)
    @comment.user = current_user
        
    if @comment.save
      flash[:notice] = "Comment was saved successfully."
      if params[:post_id]
        redirect_to [@parent.topic,@parent]
      elsif params[:topic_id]
        redirect_to @parent
      end
    else
      flash[:alert] = "Comment was failed to save."
      if params[:post_id]
        redirect_to [@parent.topic,@parent]
      elsif params[:topic_id]
        redirect_to @parent
      end
    end
  end
  
  def destroy
    id = params[:post_id] || params[:topic_id]
    if params[:post_id]
      @parent = Post.find(id)

    elsif params[:topic_id]
      @parent = Topic.find(id)
        
    end
    @comment = @parent.comments.find params[:id]
    
    if @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      if params[:post_id]
        redirect_to [@parent.topic,@parent]
      elsif params[:topic_id]
        redirect_to @parent
      end
    else
      flash.now[:alert] = "There was an error deleting the topic."
      if params[:post_id]
        redirect_to [@parent.topic,@parent]
      elsif params[:topic_id]
        redirect_to @parent
      end
    end
  end


  private
  def comment_params
       params.require(:comment).permit(:body)
  end
  def authorize_user
       comment = Comment.find(params[:id])
      unless current_user == comment.user || current_user.admin?
         flash[:alert] = "You do not have permission to delete a comment."
         redirect_to [comment.post.topic, comment.post]
      end
  end
end