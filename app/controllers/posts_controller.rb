class PostsController < ApplicationController
  before_action :require_sign_in, except: :show

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @comment = @post.comments.new(comment_params)

    @post.user = current_user

    if @post.save || @comment.save
      @post.labels = Label.update_labels(params[:post][:labels])
      @post.comments = Comment.update_comments(params[:post][:comments])
      flash[:notice] = "Post was saved successfully."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end
  def show
    @post = Post.find(params[:id])
    @post.comments = params[:post][:comments] unless params[:post].nil?
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
     @post = Post.find(params[:id])
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @post.assign_attributes(post_params)

     if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was updated successfully."
      redirect_to [@post.topic, @post]

     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
     end
  end
  def destroy
     @post = Post.find(params[:id])

     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
  end
  
  private
 
   def post_params
     params.require(:post).permit(:title, :body)
   end
   
   def comment_params
     params.require(:comment).permit(:body)
   end
end
