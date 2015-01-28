class UsersController < ApplicationController

include ApplicationHelper

  before_filter :authorized?, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to posts_path
    else
      @already_email_error = "Email already exists in our system. Sign in!"
      render 'new'
    end
  end

  def new
    @user = User.new
    if request.xhr?
      render partial: 'form', layout: false
    end
  end

  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
      @posts = @user.posts
      @comments = @user.comments
      @down_votes = @user.votes.where(value: -1)
      p @down_votes
      @up_votes = @user.votes.select {|vote| vote.value == 1}
    else
      redirect_to posts_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end


end


