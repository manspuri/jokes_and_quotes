class UsersController < ApplicationController

include ApplicationHelper

  before_filter :authorized?, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      @errors = @user.errors.full_messages
      if request.xhr?
        options = _normalize_render(:new, { layout: false })
        rendered = render_to_body(options)
        render json: { user_error: true, sign_in_html: rendered }
      else
        render :new
      end
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
      @post_comments = @user.get_post_comments
      @down_votes = @user.votes.where(value: -1)
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


