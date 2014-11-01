class VotesController < ApplicationController
  def create

    # unless current_user
    #   @error = "You must be logged in to do that!"
    #   @posts = Post.all
    #   render "posts/index"
    # end


    @context = context
    @vote = @context.votes.new(vote_params)
    @vote.user = User.find(session[:user_id])
    p @vote

    if @vote.save
      p @vote
      redirect_to context_url
    end
  end

  def update
    @context = context
    @vote = @context.votes.find(params[:id])

    if @vote.update_attributes(vote_params)
      redirect_to context_url
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
