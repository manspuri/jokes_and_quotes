module VoteHelper

  def self.find_vote(votes, post)
    votes.find_by(voteable_id: post.id, voteable_type: post.stringify_class)
  end

  def upvote
    self.value = 1
  end

  def downvote
    self.value = -1
  end

  def put_or_post
    if self.value == 0
      return :post
    else
      return :put
    end
  end
end
