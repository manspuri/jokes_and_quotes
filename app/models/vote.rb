class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :voteable, polymorphic: true

  validates :user, presence: true

  include VoteHelper

  def self.tally(voteable_id, voteable_type)
    votes = Vote.where(voteable_id: voteable_id, voteable_type: voteable_type)
    votes.empty? ? 0 : votes.sum(:value)
  end

end

