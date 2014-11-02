module UserHelper
  def voted?(post)
    self.votes.pluck(:voteable_id).include?(post.id)
  end
end
