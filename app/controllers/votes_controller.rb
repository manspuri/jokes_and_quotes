class VotesController < ApplicationController

  # def show
  #   @post = Post.find(params[:post_id])
  #   @votes = @post.votes
  #   render partial: 'votes/post_votes'
  # end

  def create
    # unless current_user
    #   @error = "You must be logged in to do that!"
    #   @posts = Post.all
    #   render "posts/index"
    # end

    @context = context
    @vote = @context.votes.new(vote_params)
    @vote.user_id = session[:user_id]

    if params[:class] == "upvote"
      @vote.upvote
    elsif params[:class] == "downvote"
      @vote.downvote
    end


    if @vote.save
      render partial: 'votes/post_votes', locals: { post: @context, votes: @context.votes }
    end
  end

  def update
    breaker = "----------------------------------"
    @context = context

    p breaker
    p "This is the context"
    p @context
    p breaker

    @vote = @context.votes.find(vote_params[:id])

    p breaker
    p "This is the found vote"
    p @vote
    p breaker
    p "These are the params"
    p vote_params
    p breaker

    update_params = {}
    if params[:class] == "upvote"
      update_params = {value: 1}

      p breaker
      p "This is the vote"
      p @vote
      p breaker

    elsif params[:class] == "downvote"
      update_params = {value: -1}

      p breaker
      p "This is the vote"
      p @vote
      p breaker

    end

    if @vote.update_attributes(update_params)

      p breaker
      p "This is the saved vote"
      p @vote
      p breaker

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
