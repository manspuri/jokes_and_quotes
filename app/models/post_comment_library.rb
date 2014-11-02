module PostCommentLibrary

	def vote_count
		self.votes.sum(:value)
	end

	def vote_count_since_days_ago(days)
		votes.where('created_at > ?', days.days.ago).sum(:value)
	end

	def self.convert_to_days(seconds)
		seconds / (60 * 60 * 24)
	end

end
