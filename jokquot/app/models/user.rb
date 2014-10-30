require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :posts
  has_many :comments
  has_many :votes

  validates :email, :first_name, :last_name, :password_hash, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password_input)
    user = User.find_by(email: email)

    if user && user.password == password_input
      return user
    end
  end
end
