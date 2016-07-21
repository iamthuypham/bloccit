require 'rails_helper'
 
 RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

  #1. Test for unauthenticated users
   context "unauthenticated users" do
    describe "GET index" do
       before { get :index, topic_id: my_topic.id, id: my_post.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_post].to_json)
       end
     end
     describe "GET show" do
       before { get :show, topic_id: my_topic.id, id: my_post.id }
       
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_post].to_json)
       end
     end
  end
  #2. Test for unathorized user
  context "unauthorized user" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end
      describe "GET index" do
       before { get :index, topic_id: my_topic.id, id: my_post.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_post].to_json)
       end
     end
     describe "GET show" do
       before { get :show, topic_id: my_topic.id, id: my_post.id }
       
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_post].to_json)
       end
     end
    end
end
