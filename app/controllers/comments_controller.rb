class CommentsController < ApplicationController
	include ApplicationHelper
	before_filter :authorized?, only: [:create]

	def new
		post = Post.find(params[:post_id])
		comment = Comment.new
		render partial: 'comments/new', locals: { post: post, comment: comment }
	end

	def create
		post = Post.find(params[:post_id])
		user = User.find(session[:user_id])
		new_comment = Comment.new(comment_params)
		new_comment.user = user
		new_comment.commentable_id = post.id
		new_comment.commentable_type = "Post"
		
		if(new_comment.save)
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

end
