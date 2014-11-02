class PostsController < ApplicationController
    #This is my best attempt at working with this before_action helper and the rails syntax for controllers. Heeeere we go...
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all       
  end

  def create
    @post = Post.new(post_params)
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

  def show
  end

  def update
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

  def destroy
    @post.destroy
    respond_to do |format|
        format.html {redirect_to posts_url, notice: 'Post was successfully destroyed, yo.'}
        format.json {head :no_content}
    end
  end

private
  def set_post
      @post = Post.find(params[:id])
  end

  def post_params
      params.require(:post).permit(:user_id,:post_type, :text)
  end

end
