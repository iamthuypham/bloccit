class PostsController < ApplicationController
  def index
    
    #retrieve first post and every fifth posts
    selected_id = (1..Post.count).select{|e| e == 1 || e % 5 ==0}
    #edit their title
    Post.where(id: selected_id).update_all("title = title || ' SPAM'")
    
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
    
  end
end
