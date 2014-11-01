require 'rails_helper'

RSpec.describe UsersController do
  let(:user_params) {{first_name: "Richard",
              last_name: "Simmons",
              email: "rich@rich.com",
              username: "richay",
              password: "cats"}}

  let(:invalid_user_params) {{first_name: "Richard",
                              last_name: "Simmons",
                              email: "",
                              username: "richay",
                              password: "cats"}}

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(response).to be_success
    end

    it "should return a new user" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe "#create" do
    context "if input is valid" do
      it "should save a user to the database and redirect to the posts page" do
        post :create, user: user_params
        expect(assigns(:user)).to be_valid
        expect(response).to redirect_to posts_path
      end
    end

    context "if input is invalid" do
      it "should redirect to sign up page" do
        post :create, user: invalid_user_params
        expect(assigns(:user)).to be_invalid
        expect(response).to render_template(:new)
      end
    end
  end
end
