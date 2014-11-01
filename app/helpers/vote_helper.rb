module VoteHelper

  def self.find_vote(votes, post)
    votes.find_by(voteable_id: post.id, voteable_type: post.stringify_class).attributes
  end

  def upvote
    self.value = 1
    self.save
    return self
  end

  def downvote
    self.value = -1
    self.save
    return self
  end

  def put_or_post
    if self.value == 0
      return :post
    else
      return :put
    end
  end
end
