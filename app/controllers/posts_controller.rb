class PostsController < ApplicationController

  include PostCommentLibrary
  include ApplicationHelper
  include PostHelper

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

    if @post.save
      redirect_to post_path(@post)
    else
      @text_error = "Text #{@post.errors.messages[:text].pop}" if @post.errors.messages[:text]
      @type_error = "Post #{@post.errors.messages[:post_type].pop}" if @post.errors.messages[:post_type]
      render :new
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
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      @text_error = "Text #{@post.errors.messages[:text].pop}" if @post.errors.messages[:text]
      @type_error = "Post #{@post.errors.messages[:post_type].pop}" if @post.errors.messages[:post_type]
      render :edit
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
