class VotesController < ApplicationController
  def create
    @context = context
    @vote = @context.votes.new(vote_params)

    if @vote.save
      redirect_to context_url(context)
    end
  end

  def update
    @context = context
    @vote = @context.votes.find(params[:id])

    if @vote.update_attributes(vote_params)
      redirect_to context_url(context)
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
