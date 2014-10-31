class PostsController < ActionController::Base

  def index

    Post.create(user_id: 1, post_type: "jok", text: "What are Mario's favorite type of pants? A. Denim denim denim", created_at: Time.now, updated_at: Time.now)

    	# @posts = Post.all
    	# @user = current_user
    	# @post = Post.find(@user.id)
    	# @votes = Vote.find(@post_id)
    	# @comments = Comment.find(@post_id)
    	# @comments_count = @post.comments.count

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
