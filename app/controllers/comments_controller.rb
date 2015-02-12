class CommentsController < ApplicationController
	include ApplicationHelper
	before_filter :authorized?, only: [:create]

	def new
		commentable = context
		comment = Comment.new
		render partial: 'comments/new', locals: { post: commentable, comment: comment }
	end

	def create
		user = User.find(session[:user_id])
		new_comment = context.comments.new(comment_params)
		new_comment.user = user
		
		if new_comment.save
			puts params
			render partial: 'show', locals: { comment: new_comment }
		else
			render json: {error: 'failed'}
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :commentable_id, :commentable_type)
	end

	def context
		if params[:post_id]
			Post.find(params[:post_id])
		elsif params[:comment_id]
			Comment.find(params[:comment_id])
		end
	end

end
