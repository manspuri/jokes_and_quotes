class VotesController < ApplicationController
  include ApplicationHelper
  before_filter :authorized?, only: [:create, :update]

  def create
    @context = context
    @vote = @context.votes.new(vote_params)
    @vote.user_id = session[:user_id]

    if params[:class] == "upvote"
      @vote.upvote
    elsif params[:class] == "downvote"
      @vote.downvote
    end

    if @context.votes.sum(:value) <= -20
      @context.destroy
      @vote.destroy
      redirect_to root_path
    end

    if @vote.save
      if @context.is_a? Post
        render partial: 'votes/post_votes', locals: { post: @context, votes: @context.votes }
      elsif @context.is_a? Comment
        render partial: 'votes/comment_votes', locals: { comment: @context, votes: @context.votes }
      end
    end
  end

  def update
    @context = context
    @vote = @context.votes.find(vote_params[:id])

    update_params = {}
    if params[:class] == "upvote" || params[:class] == "comment-upvote"
      update_params = {value: 1}
    elsif params[:class] == "downvote" || params[:class] == "comment-downvote"
      update_params = {value: -1}
    end

    if @vote.update_attributes(update_params)
      if @context.is_a? Post
        render partial: 'votes/post_votes', locals: { post: @context, votes: @context.votes }
      elsif @context.is_a? Comment
        render partial: 'votes/comment_votes', locals: { comment: @context, votes: @context.votes }
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit!
  end

  def context
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end

  def context_url
    if Post === context
      post_path(context)
    elsif Comment === context
      comment_path(context)
    end
  end
end
