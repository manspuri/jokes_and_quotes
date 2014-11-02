module UserHelper
  def voted?(post)
    self.votes.pluck(:voteable_id).include?(post.id)
  end

  def upvoted?(post)
    self.votes.find_by(voteable_id: post.id).value == 1
  end

  def downvoted?(post)
    self.votes.find_by(voteable_id: post.id).value == -1
  end

  def upvoted_or_downvoted(post)
    if voted?(post)
      if downvoted?(post)
        return "downvoted"
      elsif upvoted?(post)
        return "upvoted"
      end
    end
  end
end
