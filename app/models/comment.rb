class Comment < ActiveRecord::Base
	include PostCommentLibrary

  belongs_to :user
  has_many   :votes, as: :voteable

  belongs_to :commentable, polymorphic: true
  has_many   :comments, as: :commentable
end
