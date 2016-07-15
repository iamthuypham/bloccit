 class Comment < ActiveRecord::Base
   belongs_to :topic
   belongs_to :post
   belongs_to :user
   
   validates :body, length: { minimum: 5 }, presence: true
    validates :user, presence: true
    
  def self.update_comments(comment)
     return Comment.none if comment.blank?
     comment.body
  end
 end