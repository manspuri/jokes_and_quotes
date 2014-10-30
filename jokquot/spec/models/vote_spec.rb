require 'rails_helper'

describe Vote do
  let(:vote) { Vote.new }
  
  let(:post) { Post.new }
  let(:current_user) { User.new }

  before do 
    allow(post).to receive(:id).and_return(1)
    allow(post).to receive(:user).and_return(current_user)
  end

  describe '#add_to' do
    it 'should add a vote to the passed in object' do
      expect{ post.votes << vote }.to change{ post.votes.length }.by(1)
    end
  end
end
