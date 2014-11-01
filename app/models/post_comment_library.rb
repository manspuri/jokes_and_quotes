module PostCommentLibrary

	def vote_count
		self.votes.sum(:value)
	end

end
