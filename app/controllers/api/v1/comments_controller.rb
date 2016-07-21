class Api::V1::CommentsController < Api::V1::BaseController
   before_action :authenticate_user, except: [:index, :show]
   before_action :authorize_user, except: [:index, :show]
   
   def show
     post = Post.find(params[:id])
     @comment = post.comment
     render json: @comment, status: 200
   end
   
   def index
     @comment = Comment.all
     render json: @comment, status: 200
   end
end