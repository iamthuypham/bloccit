class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :topic
  accepts_nested_attributes_for :post, :topic
  
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
  
  def self.update_comments(comments)
    return Comment.none if comments.blank?
    comments.map do |comment|
       Comment.find_or_create_by(body: comment)
    end
  end
end
