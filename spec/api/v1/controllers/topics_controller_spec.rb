require 'rails_helper'
 
 RSpec.describe Api::V1::TopicsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
 
   context "unauthenticated user" do
     describe "GET index" do
       before { get :index, id: my_topic.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq([my_topic].to_json)
       end
     end

     describe "GET show" do
       before { get :show, id: my_topic.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end
 
       it "returns my_user serialized" do
         expect(response.body).to eq(my_topic.to_json)
       end
     end
   end
 
   context "unauthorized user" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

     describe "GET index" do
       before { get :index, id: my_topic.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end
 
       it "returns my_topic serialized" do
         expect(response.body).to eq([my_topic].to_json)
       end
     end

     describe "GET show" do
       before { get :show, id: my_topic.id }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end
 
       it "returns my_topic serialized" do
         expect(response.body).to eq(my_topic.to_json)
       end
     end
   end
 end