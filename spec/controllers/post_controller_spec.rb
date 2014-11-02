 require 'rails_helper'

describe PostsController do

  let(:user) { User.create}
  let(:post) { Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")}

  	describe "#index" do 
  		it "should assign posts" do
            get :index
  		expect(post.count).to be_greater_than(1)
  	end
  end

  	describe "#index" do 
  		it "should have a post with a username" do
            get :index
  		expect(post.user.username).to not_be_nil
  	end
  end

  	describe "#index" do 
  		it "should have a post with a created_at date" do
            get :index
  		expect(post.created_at).to not_be_nil
  	end
  end

  	describe "#index" do
  			it "should have a post with some text" do
            get :index 
  		expect(post.text).to not_be_nil
  	end
  end

  # 	describe "#create" do 
  # 		it "should save a post" do 
  #           post :create
  # 		expect(assigns(:posts).)
  # 	end
  # end

  # 	describe "#create" do 
  # 		it "should not save a post without any text" do
        
  #           post :create
  # 		expect(assigns(:posts).)
  # 	end
  # end

  # 	describe "#create" do 
  # 		it "should redirect to #show when it saves" do
        
  #           post :create
  # 		expect(assigns(:posts))
  # 	end
  # end

  	describe "#show" do 
  		it "should show a single post" do
        
            get :show
  		expect(assigns(post).length).to eq(1)
  	end
  end

  # 	describe "#update" do 
  # 		it "should save new user input" do
        
  #           post :update
  # 		expect(assigns(:posts).)
  # 	end
  # end

  # 	describe "#update" do 
  # 		it "should change the database to the new user input" do
        
  #           post :update
  # 		expect(assigns(:posts).)
  # 	end
  # end

  	describe "#destroy" do 
  		it "should delete a post" do
        
            delete :delete
  		expect(assigns(post).text).to be_nil
  	end
  end

end