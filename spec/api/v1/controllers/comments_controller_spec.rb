require 'rails_helper'
include SessionsHelper

RSpec.describe Api::V1::CommentsController, type: :controller do
   let(:my_topic) { create(:topic) }
   let(:my_user) { create(:user) }
   let(:other_user) { create(:user) }
   let(:my_post) { create(:post, topic: my_topic, user: my_user) }
   let(:my_comment) { Comment.create!(body: 'Comment Body', post: my_post, user: my_user) }
 
   context "unauthenticated user" do
     describe "GET index" do
       before { get :index, topic_id: my_topic.id, post_id: my_post.id, id: my_comment.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_comment].to_json)
       end
     end
     describe "GET show" do
       before { get :show, topic_id: my_topic.id, post_id: my_post.id, id: my_comment.id }
       
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_comment].to_json)
       end
     end
   end
   context "unauthorized user" do
     before do
       create_session(other_user)
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)

     end
     
     describe "GET index" do
       before { get :index, topic_id: my_topic.id, post_id: my_post.id, id: my_comment.id}
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_comment].to_json)
       end
     end
     describe "GET show" do
       before { get :show, topic_id: my_topic.id, post_id: my_post.id, id: my_comment.id }
       
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_comment].to_json)
       end
     end
   end
end
