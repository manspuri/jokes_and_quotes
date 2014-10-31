class UsersController < ActionController::Base

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
end

