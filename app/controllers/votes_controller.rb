class VotesController < ApplicationController
  include ApplicationHelper
  before_filter :authorized?, only: [:create, :update]

  def create

    @context = context
    @vote = @context.votes.new(vote_params)
    @vote.user_id = session[:user_id]

    if(request.referer.match(/\/posts\/\d+/i))
      user = User.find(session[:user_id])
      vote = Vote.new(vote_params)
      vote.user = user
      if(vote.save)
        render json: {
          id: vote.id,
          votes: vote.value,
          username: vote.user.username,
          date: vote.voteable_type,
          text: vote.voteable_id
        }
      else
        render json: {error: 'failed'}
      end
    else
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
      end

      if @vote.save
        render partial: 'votes/post_votes', locals: { post: @context, votes: @context.votes }
      end
    end
  end

  def update
    @context = context
    @vote = @context.votes.find(vote_params[:id])

    update_params = {}
    if params[:class] == "upvote"
      update_params = {value: 1}
    elsif params[:class] == "downvote"
      update_params = {value: -1}
    end

    if @vote.update_attributes(update_params)
      render partial: 'votes/post_votes', locals: { post: @context, votes: @context.votes }
    end
  end

  private

  def vote_params
    params.require(:vote).permit!
  end

  def context
    if params[:post_id]
      id = params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      id = params[:comment_id]
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
