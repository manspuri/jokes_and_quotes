require 'rails_helper'

describe Vote do
  let(:vote) { Vote.new }
  
  let(:post) { Post.new }
  let(:current_user) { User.new }

  before do 
    allow(post).to receive(:id).and_return(1)
    allow(post).to receive(:user).and_return(current_user)
  end

  describe '#upvote' do 
    it 'should change the value to 1' do
      expect{ vote.upvote }.to change{ vote.value }.by(1)
    end

    it 'should not change the value more than once' do
      vote.upvote
      expect{ vote.upvote }.not_to change{ vote.value }
    end
  end

  describe '#downvote' do
    it 'should change the value to -1' do
      expect{ vote.downvote }.to change{ vote.value }.by(-1)
    end

    it 'should not change the value more than once' do
      vote.downvote
      expect{ vote.downvote }.not_to change{ vote.value }
    end
  end

  describe '.tally' do
    before do
      post.votes = [ Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).upvote, 
                     Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).upvote, 
                     Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).downvote ]
    end

    it "should return an object's total points for the object" do
      expect(Vote.tally(post.id, post.class)).to eq(1)
    end

    it "should be responsive" do
      post.votes << Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).downvote
      post.votes << Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).downvote
      post.votes << Vote.new(user: current_user, voteable_id: post.id, voteable_type: post.class.to_s).downvote
      expect(Vote.tally(post.id, post.class)).to eq(-2)
    end
  end

  describe '#put_or_post' do
    before do
      vote.user = current_user
    end

    it 'should return post if the vote value is 0' do
      vote.save
      expect( vote.put_or_post ).to eq("post")
    end

    it 'should return put if the vote value is 1' do
      vote.upvote
      expect( vote.put_or_post ).to eq("put")
    end

    it 'should return put if the vote value is -1' do
      vote.downvote
      expect( vote.put_or_post ).to eq("put")
    end
  end
end
