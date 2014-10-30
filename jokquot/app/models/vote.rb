class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :voteable, polymorphic: true

  validates :user, presence: true

  def upvote(post_or_comment, post_or_comment_id)
    voteable_object = post_or_comment.class.find(post_or_comment_id)

    voteable_object.votes << self
  end

  def downvote(post_or_comment, post_or_comment_id)
    voteable_object = post_or_comment.class.find(post_or_comment_id)

    

  end
end
