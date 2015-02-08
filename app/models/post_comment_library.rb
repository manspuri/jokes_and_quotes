module PostCommentLibrary
  def count_subcomments(post)
    if post.comments.size == 0
      return post.comments.size
    end
    post.comments.size + all_comments(post.comments)
  end

  def all_comments(collection)
    counted = collection.map { |comment| count_subcomments(comment) }
    if counted.empty?
      comment_count = 0
    else
      comment_count = counted.inject(:+)
    end
    comment_count
  end

  def comment_count
    self.all_comments(self.comments) + self.comments.size
  end

	def vote_count_since_days_ago(days)
		votes.where('created_at > ?', days.days.ago).sum(:value)
	end
end
