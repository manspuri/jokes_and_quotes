class Comment < ActiveRecord::Base
  belongs_to :user
  has_many   :votes, as: :voteable

  belongs_to :commentable, polymorphic: true
  has_many   :sub_comments, as: :commentable, class_name: "Comment"
end


