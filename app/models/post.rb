class Post < ActiveRecord::Base
  belongs_to :user
  has_many   :votes, as: :voteable
  has_many   :comments, as: :commentable

  def get_comments_json
  	build_comments_nest(self)
  end

  private

  def build_comments_nest(user_submission)
  	final = user_submission.comments.map do |comment|
  		build_comment_json(comment)
  	end
    final == [] ? {} : final
  end

  def build_comment_json(comment)
  	obj = { "text" => comment.text,
  					"username" => comment.user.username }
  	if comment.comments.count > 0
  		obj["comments"] = build_comments_nest(comment)
  	end
  	obj
  end
end
