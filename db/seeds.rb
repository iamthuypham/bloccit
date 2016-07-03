require 'random_data'

 50.times do
   Post.create!(
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
 
 unique_post_data  = {
     title: "Assignment-30 Post", 
     body: "This is a unique post to assignment 30!"
 }
 unique_post = Post.find_or_create_by(unique_post_data)
 
 unique_comment_data  = {
     body: "This is a unique comment to assignment 30!"
 }
 
 unique_post.comments.find_or_create_by(unique_comment_data)

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"