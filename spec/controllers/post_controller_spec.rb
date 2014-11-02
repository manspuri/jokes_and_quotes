 require 'rails_helper'

describe PostsController do
  	describe "#index" do 
  		it "should assign posts" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            get :index
  		expect(assigns(:posts).length).to eq(1)
  	end
  end

  	describe "#index" do 
  		it "should have a post with a username" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            get :index
  		expect(assigns(:posts).user.username).to not_be_nil
  	end
  end

  	describe "#index" do 
  		it "should have a post with a created_at date" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            get :index
  		expect(assigns(:posts).created_at).to not_be_nil
  	end
  end

  	describe "#index" do
  			it "should have a post with some text" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            get :index 
  		expect(assigns(:posts).text).to not_be_nil
  	end
  end

  	describe "#create" do 
  		it "should save a post" do 
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            post :create
  		expect(assigns(:posts).)
  	end
  end

  	describe "#create" do 
  		it "should not save a post without any text" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            post :create
  		expect(assigns(:posts).)
  	end
  end

  	describe "#create" do 
  		it "should redirect to #show when it saves" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            post :create
  		expect(assigns(:posts))
  	end
  end

  	describe "#show" do 
  		it "should show a single post" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            get :show
  		expect(assigns(:posts).length).to eq(1)
  	end
  end

  	describe "#update" do 
  		it "should save new user input" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            post :update
  		expect(assigns(:posts).)
  	end
  end

  	describe "#update" do 
  		it "should change the database to the new user input" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            post :update
  		expect(assigns(:posts).)
  	end
  end

  	describe "#destroy" do 
  		it "should delete a post" do
        Post.create(user_id: 1, post_type:"joke", text: "What do you call a man with a rubbertoe? Roberto")
            delete :delete
  		expect(assigns(:posts).text).to be_nil
  	end
  end

end