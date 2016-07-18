class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :member }
  
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
 
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
 
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 254 }
 
  has_secure_password
  
  enum role: [:member, :admin]
  
  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end
  
  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
  
  def have_any_post?
    self.posts.count > 0
  end
  def have_any_comment?
    self.comments.count > 0
  end
  
  def favorite_post_of(user)
    mark_fav = Favorite.where(user_id: user.id) #Find which favorite comes from a given user
    list_fav_postID = mark_fav.pluck(:post_id) #Then find which post id that user marked favorite
    @favorite_post = Post.where(id: list_fav_postID) #Then find post that user marked favorite
  end
  def avatar_of_favorite_post(favorite_post, size)
    @user = favorite_post.user
    gravatar_id = Digest::MD5::hexdigest(@user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
  def number_of_votes(user, a_favorite_post)
    have_vote = Vote.where(user_id: user.id, post_id: a_favorite_post.id)
    have_vote.count
  end
  
  def number_of_comments(user, a_favorite_post)
    have_comment = Comment.where(user_id: user.id, post_id: a_favorite_post.id)
    have_comment.count
  end
end
