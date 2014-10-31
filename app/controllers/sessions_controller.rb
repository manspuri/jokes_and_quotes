class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(session_params)

    if @user
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      @user = User.new
      @error = "Sorry, we don't recognize that email and password.  Why don't you sign up?"
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] == nil
    redirect_to posts_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

