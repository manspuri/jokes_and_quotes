class CommentsController < ApplicationController



	def create
		user = User.find(session[:user_id])
		comment = Comment.new(comment_params)
		comment.user = user
		if(comment.save)
			render json: {
				id: comment.id,
				votes: comment.vote_count,
				username: comment.user.username,
				date: comment.created_at,
				text: comment.text
			}
		else
			render json: {error: 'failed'}
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :commentable_id, :commentable_type)
	end

end
