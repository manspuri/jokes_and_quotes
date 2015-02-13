require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  include UserHelper

  has_many :posts
  has_many :comments
  has_many :votes

  validates :email, :first_name, :last_name, :password_hash, :username, presence: true
  validates :email, :username, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def get_post_comments
    post_comments = []
    unless self.comments.empty?
      self.comments.each do |comment| 
        if comment.commentable_type == "Post"
          post_comments << Post.find(comment.commentable_id)
        end
      end
    end
    post_comments.uniq
  end

  def self.authenticate(params)
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
      return user
    end
  end
end
