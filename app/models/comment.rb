class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :topic
  accepts_nested_attributes_for :post, :topic
  
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
  
  def self.show_comments_in_topic(comments)
     comments.split(",").map do |comment|
       Label.find_or_create_by(body: comment.strip)
     end
  end
end
