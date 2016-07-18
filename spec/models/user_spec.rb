require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }

   # Shoulda tests for name
   it { is_expected.to validate_presence_of(:name) }
   it { is_expected.to validate_length_of(:name).is_at_least(1) }
 
   # Shoulda tests for email
   it { is_expected.to validate_presence_of(:email) }
   it { is_expected.to validate_uniqueness_of(:email) }
   it { is_expected.to validate_length_of(:email).is_at_least(3) }
   it { is_expected.to allow_value("user@bloccit.com").for(:email) }
 
   # Shoulda tests for password
   it { is_expected.to validate_presence_of(:password) }
   it { is_expected.to have_secure_password }
   it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
   describe "attributes" do
     it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
     end
   end
   describe "invalid user" do
     let(:user_with_invalid_name) { build(:user, name: "") }
     let(:user_with_invalid_email) { build(:user, email: "") }
 
     it "should be an invalid user due to blank name" do
       expect(user_with_invalid_name).to_not be_valid
     end
 
     it "should be an invalid user due to blank email" do
       expect(user_with_invalid_email).to_not be_valid
     end
 
   end
   
   describe "attributes" do
     it "responds to role" do
       expect(user).to respond_to(:role)
     end
     it "responds to admin?" do
       expect(user).to respond_to(:admin?)
     end
     it "responds to member?" do
       expect(user).to respond_to(:member?)
     end
   end

   describe "roles" do
      it "is member by default" do
       expect(user.role).to eq("member")
      end
      context "member user" do
       it "returns true for #member?" do
         expect(user.member?).to be_truthy
      end
      it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
      end
   end
     context "admin user" do
       before do
         user.admin!
       end
 
       it "returns false for #member?" do
         expect(user.member?).to be_falsey
       end
 
       it "returns true for #admin?" do
         expect(user.admin?).to be_truthy
       end
     end
   
  describe "#favorite_for(post)" do
    before do
       topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end
 
    it "returns `nil` if the user has not favorited the post" do
       expect(user.favorite_for(@post)).to be_nil
    end
 
    it "returns the appropriate favorite if it exists" do
       favorite = user.favorites.where(post: @post).create
       expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "blochead@bloc.io") }
 
    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end
end
  describe "favorite_posts_of_a_given_user" do
      before do
       topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post1 = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
      @user1 = User.create!(name: "Tester", email:"tester@example.com", password: "password")
       Favorite.create!(user_id: @user1.id, post_id: @post1.id)
      end
      it "returns the list of favorite posts" do
      expect(@user1.favorite_post_of(@user1)).to eq([@post1])
      end
    
      it "returns number of votes" do
        Vote.create!(user_id: @user1.id, post_id: @post1.id, value: 1)
        votes = Vote.where(user_id: @user1.id, post_id: @post1.id)
        expect(@user1.number_of_votes(@user1, @post1)).to eq(votes.count)
        p "Number of votes: #{votes.count}"
      end
      it "returns number of comments" do
        Comment.create!(user_id: @user1.id, post_id: @post1.id, body: "This is comment from user1 for post1")
        comments = Comment.where(user_id: @user1.id, post_id: @post1.id)
        expect(@user1.number_of_comments(@user1, @post1)).to eq(comments.count)
        p "Number of comments: #{comments.count}"
      end
    end
end
