require 'rails_helper'

describe User do

  describe "user attributes" do

    before do
      @user = User.create!(first_name: "Richard", last_name: "Simmons", email: "rich@aol.com", username: "richay", password_hash: "password")
    end

    it 'has a first_name' do
      expect(@user.first_name).to eq("Richard")
    end

    it 'has a last_name' do
      expect(@user.last_name).to eq("Simmons")
    end

    it 'has an email' do
      expect(@user.email).to eq("rich@aol.com")
    end
  end

  describe "validations" do

    let(:user) {User.new}

    it 'should not be valid without a first_name' do
      user.last_name = "Simmons"
      user.email = "rich@aol.com"
      user.username = "richay"
      user.password_hash = "cats"
      expect(user.valid?).to eq(false)
    end

    it 'should not be valid without a last_name' do
      user.first_name = "Richard"
      user.email = "rich@aol.com"
      user.username = "richay"
      user.password_hash = "cats"
      expect(user.valid?).to eq(false)
    end

    it 'should not be valid without an email' do
      user.first_name = "Richard"
      user.last_name = "Simmons"
      user.username = "richay"
      user.password_hash = "cats"
      expect(user.valid?).to eq(false)
    end

    it 'should not be valid without a password_hash' do
      user.first_name = "Richard"
      user.last_name = "Simmons"
      user.email = "rich@aol.com"
      user.username = "richay"
      expect(user.valid?).to eq(false)
    end

    it 'should not be valid without a username' do
      user.first_name = "Richard"
      user.last_name = "Simmons"
      user.email = "rich@aol.com"
      user.password_hash = "cats"
      expect(user.valid?).to eq(false)
    end
  end

end
