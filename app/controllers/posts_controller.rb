class PostsController < ApplicationController

include PostCommentLibrary
include ApplicationHelper
    #This is my best attempt at working with this before_action helper and the rails syntax for controllers. Heeeere we go...
  before_action :set_post, only: [:show, :edit, :update]
  before_filter :authorized?, only: [:new, :edit, :update, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    unless session[:user_id].nil?
      @votes = User.find(session[:user_id]).votes
    end
    respond_to do |format|
      if @post.save
        format.html {redirect_to @post, notice:'Post was successfully created, yo.'}
        format.json {render :show, status: :created, location: @post}
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: unprocessable_entity}
      end
    end
  end

  def show
    @comments = @post.comments if @post.has_comments?
  end

  def edit
    if current_user != @post.user || !@post.editable?
      redirect_to post_path(@post)
    end
  end

  def update
    if @post.votes != nil && @post.comments != nil
      respond_to do |format|
        if @post.update(post_params)
          format.html {redirect_to @post, notice: 'Post was successfully updated, yo.'}
          format.json {render :show, status: :ok, location: @post}
        else
          format.html {render :edit}
          format.json {render json: @post.errors, status: unprocessable_entity}
        end
      end
    end
  end

private
  def set_post
      @post = Post.find(params[:id])
  end

  def post_params
      params.require(:post).permit(:post_type, :text)
  end

end
