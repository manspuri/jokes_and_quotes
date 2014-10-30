class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :voteable, polymorphic: true

  validates :user, presence: true

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

  def self.tally(voteable_id, voteable_type)
    votes = Vote.where(voteable_id: voteable_id, voteable_type: voteable_type)
    votes.sum(:value)
  end
end




