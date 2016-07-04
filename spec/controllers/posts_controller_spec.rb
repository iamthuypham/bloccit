require 'rails_helper'

RSpec.describe PostsController, type: :controller do
   let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_post] to @posts" do
       get :index
       expect(assigns(:posts)).to eq([my_post])
    end
    
    #Assignment-31-Test
    it "Post is SPAM" do
      if my_post.id == 1 || my_post.id % 5 == 0
    #add "SPAM" string in their title
          my_post.title = my_post.title + ' SPAM'
    #retrieve those post
      end
      get :index
      expect(assigns(:posts).pluck(:title)).to eq([my_post.title])
    end
  end
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  
  
end
