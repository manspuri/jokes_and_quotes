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
    before(:each) do
      @params = {email: "rich@rich.com", password: "dogs"}
      expect(User).to receive(:authenticate).with(email: @params[:email], password: @params[:password]).and_return(nil)
    end

    # not working yet
    it 'should re-render the new page' do
      post :create, session: @params
      expect(response).to render_template('new')
    end
  end
end


      # response.should have_tag("form[action=/sessions]") do
      #   with_tag "input[type=text_field][name=email]"
      #   expect(page).to have_field("email")
      #   with_tag "input[type=password_field][name=password]"
      #   expect(page).to have_field("password")
      # end
