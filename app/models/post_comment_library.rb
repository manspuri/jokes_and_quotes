module PostCommentLibrary

	def vote_count
		votes.sum(:value)
	end

end