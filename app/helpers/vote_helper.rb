module VoteHelper

  def find_vote(votes, post)
    votes.find_by(voteable_id: post.id, voteable_type: post.stringify_class)
  end
end
