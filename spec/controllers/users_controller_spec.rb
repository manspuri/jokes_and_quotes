require 'rails_helper'

describe UsersController do

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
end
