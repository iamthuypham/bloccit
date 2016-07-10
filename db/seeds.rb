require 'random_data'
 5.times do
   User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
 end
 users = User.all
 15.times do
     Topic.create!(
     name:         RandomData.random_sentence,
     description:  RandomData.random_paragraph
   )
 end
 
 topics = Topic.all

 50.times do
     Post.create!(
     user:   users.sample,
     topic: topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 posts = Post.all
 
 100.times do
     Comment.create!(
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end
 
 100.times do
   Question.create!(
     title:  RandomData.random_question,
     body:   RandomData.random_paragraph,
     resolved: false
   )
   
 end
 
 user = User.first
 user.update_attributes!(
   email: 'thpham100@gmail.com',
   password: 'password'
 )
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 puts "#{Question.count} questions created"