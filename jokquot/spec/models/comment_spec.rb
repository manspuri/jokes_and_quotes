require 'rails_helper'

describe Comment do
  let(:comment) { Comment.new }

  before do
    allow(comment).to receive(:user).and_return( "Isaac" )
    allow(comment).to receive(:votes).and_return( 24 )

    comment.save!
  end

  it 'should have a user' do
    expect{ comment.user }.not_to raise_error
  end

  it 'should have a commentable type' do
    expect{ comment.commentable_type }.not_to raise_error
  end

  it 'should have votes' do
    expect{ comment.votes }.not_to raise_error
  end

  it 'should have sub_comments' do
    expect{ comment.sub_comments }.not_to raise_error
  end
end
