class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :voteable, polymorphic: true

  validates :user, presence: true

  def upvote
    self.value = 1
    self.save
  end

  def downvote
    self.value = -1
    self.save
  end

  def self.tally_votes_for(voteable_object)
    votes = Vote.where(voteable_id: voteable_object.id)
    votes.sum(:value)
  end
end




