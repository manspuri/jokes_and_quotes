class PostsController < ApplicationController

  def index
    @posts = Post.all

    unless session[:user_id].nil?
      @votes = User.find(session[:user_id]).votes
    end
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

end
