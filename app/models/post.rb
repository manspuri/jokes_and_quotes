class Post < ActiveRecord::Base
  include PostCommentLibrary

  belongs_to :user
  has_many   :votes, as: :voteable
  has_many   :comments, as: :commentable

  default_scope { order(vote_total: :desc) }

  def author
    self.user
  end

  def editable?
    self.votes.empty? && self.comments.empty?
  end

  def has_comments?
    !self.comments.empty?
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


  def self.find_by_text(text)
    results = Post.where("text like ?", "%#{text}%")

    self.sort_by_created_at_desc(results)
  end
end
