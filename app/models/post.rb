class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :topic
  belongs_to :user
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  after_create :auto_favorite_own_post
  after_create :send_new_own_post
  
  default_scope { order('rank DESC') }
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  
  def up_votes
    votes.where(value: 1).count
  end
 
  def down_votes
    votes.where(value: -1).count
  end
 
  def points
    votes.sum(:value)
  end
  
  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
  
  def auto_favorite_own_post
    user.favorites.create(user: user, post: self)
  end
  
  def send_new_own_post
    FavoriteMailer.new_post(user, topic, self).deliver_now
  end
end
