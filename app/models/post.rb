class Post < ActiveRecord::Base
  
  include PostCommentLibrary

  belongs_to :user
  has_many   :votes, as: :voteable
  has_many   :comments, as: :commentable

  def editable?
    self.comments.empty? && self.votes.empty?
  end

  def get_comments_json
  	build_comments_nest(self)
  end

  def stringify_class
    self.class.to_s
  end

  def self.sort_by_type(type)
    results = Post.all.select do |post|
      post.post_type == type
    end

    self.sort_by_created_at_desc(results)
  end

  def self.sort_by_user(username)
    results = Post.all.select do |post|
      post.user.username == username
    end

    self.sort_by_created_at_desc(results)
  end

  def self.sort_by_popularity
    Post.all.map do |post|
      [post, post.vote_count]
    end.sort do |p1, p2|
      p2[1] <=> p1[1]
    end.map do |array|
      array[0]
    end
  end

  def self.sort_by_created_at_desc(posts)
    posts.sort do |p1, p2|
      p2.created_at <=> p1.created_at
    end
  end

  def self.sort_by_trending
    Post.all.map do |post|
      [post, post.trending_value]
    end.sort do |p1, p2|
      p2[1] <=> p1[1]
    end.map do |array|
      array[0]
    end
  end

  def trending_value
    days_ago = 14.0
    total_votes = vote_count_since_days_ago(days_ago)
    time_now = Time.now.in_time_zone('Central Time (US & Canada)')
    time_created = created_at.in_time_zone('Central Time (US & Canada)')
    total_days = PostCommentLibrary.convert_to_days(time_now - time_created) > days_ago ? days_ago : PostCommentLibrary.convert_to_days(time_now - time_created)
    total_votes / total_days
  end

  def self.find_by_text(text)
    results = Post.where("text like ?", "%#{text}%")

    self.sort_by_created_at_desc(results)
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
  					"username" => comment.user.username,
            "date" => "#{comment.created_at.to_date}",
            "votes" => "#{comment.vote_count}",
            "id" => "#{comment.id}" }
  	if comment.comments.count > 0
  		obj["comments"] = build_comments_nest(comment)
  	end
  	obj
  end

end
