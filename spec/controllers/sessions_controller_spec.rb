require 'rails_helper'

describe SessionsController do

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

  describe "POST 'create'" do
    # before(:each) do
    #   @params = {email: "rich@rich.com", password: "dogs"}
    #   expect(User).to receive(:authenticate).with(email: @params[:email], password: @params[:password]).and_return(nil)
    # end
    context 'if login was unsuccessful' do
      it 'should redirect to the sign-up page' do
        @params = {email: "rich@rich.com", password: "dogs"}
        expect(User).to receive(:authenticate).with(email: @params[:email], password: @params[:password]).and_return(nil)
        post :create, session: @params
        expect(response).to redirect_to(new_user_path)
      end
    end

    # context 'if login was successful' do
    #   it 'should redirect to the posts page' do
    #     @params = {email: "rich@rich.com", password: "cats"}
    #     expect(User).to receive(:authenticate).with(email: @params[:email], password: @params[:password]).and_return(@user)
    #     post :create, session: @params
    #     expect(response).to redirect_to(posts_path)
    #   end
    # end

  end
end


      # response.should have_tag("form[action=/sessions]") do
      #   with_tag "input[type=text_field][name=email]"
      #   expect(page).to have_field("email")
      #   with_tag "input[type=password_field][name=password]"
      #   expect(page).to have_field("password")
      # end
