module UserHelper
  def voted?(post)
    self.votes.to_a.include?(Vote.find_by(voteable_id: post.id, voteable_type: post.stringify_class))
  end
end
