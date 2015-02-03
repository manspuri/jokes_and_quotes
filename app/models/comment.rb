class Comment < ActiveRecord::Base
	include PostCommentLibrary

  belongs_to :user
  has_many   :votes, as: :voteable

  belongs_to :commentable, polymorphic: true
  has_many   :comments, as: :commentable

  validates_length_of :text, minimum: 1

  def author
    self.user.username
  end

  def has_comments?
    !self.comments.empty?
  end

  def stringify_class
    self.class.to_s
  end
end
