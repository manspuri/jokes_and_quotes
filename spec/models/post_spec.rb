require 'rails_helper'
require 'pp'

describe Post do
	it "should have text"	do
		text = "Why don't they have gambling in Africa? Too many cheetahs"
		p = Post.new(text: text)
		expect(p.text).to eq text
	end

	describe '#get_comments_json' do
		before(:each) {
			@types = ['joke', 'quote']
			@user = User.create!(
				first_name: 'Dustin',
				last_name: 'Snyder',
				email: 'roboprog010@gmail.com',
				username: 'dks',
				password_hash: 'password'
			)
			@post = Post.create!(
				user: @user,
				post_type:	@types.sample,
				text: 'Post Title'
			)
		}

		after(:each) {
			User.destroy_all
			Post.destroy_all
			Comment.destroy_all
		}

		it 'returns a JSON obj representing a single level of comments' do
			@post.comments << (1..5).to_a.map do
				Comment.create!(
					user: @user,
					commentable_id:	@post.id,
					commentable_type: 'Post',
					text: 'Comment Text'
				)
			end

			got_json = @post.get_comments_json

			expect(got_json.count).to eq(5)
			expect(got_json[0]).to eq({
				"text" => "Comment Text",
				"username" => "dks"
			})
		end

		it 'returns a JSON obj representing a two levels of comments' do
			@post.comments << (1..5).to_a.map do
				Comment.create!(
					user: @user,
					commentable_id:	@post.id,
					commentable_type: 'Post',
					text: 'Comment Text'
				)
			end

			@post.comments.each do |comment|
				comment.comments << (1..5).to_a.map do
					Comment.create!(
						user: @user,
						commentable_id:	comment.id,
						commentable_type: 'Comment',
						text: 'Comment Text'
					)
				end
			end

			got_json = @post.get_comments_json
			
			expect(got_json[0]["comments"].count).to eq(5)
			expect(got_json[0]["comments"][0]).to eq({
				"text" => "Comment Text",
				"username" => "dks"
			})
		end

		it 'returns a JSON obj representing a three levels of comments' do
			@post.comments << (1..5).to_a.map do
				Comment.create!(
					user: @user,
					commentable_id:	@post.id,
					commentable_type: 'Post',
					text: 'Comment Text'
				)
			end

			@post.comments.each do |comment|
				comment.comments << (1..5).to_a.map do
					Comment.create!(
						user: @user,
						commentable_id:	comment.id,
						commentable_type: 'Comment',
						text: 'Comment Text'
					)
				end
			end

			@post.comments.each do |comment|
				comment.comments.each do |sub_comment|
					sub_comment.comments << (1..5).to_a.map do
						Comment.create!(
							user: @user,
							commentable_id:	sub_comment.id,
							commentable_type: 'Comment',
							text: 'Comment Text'
						)
					end
				end
			end

			got_json = @post.get_comments_json
			
			expect(got_json[0]["comments"][0]["comments"].count).to eq(5)
			expect(got_json[0]["comments"][0]["comments"][0]).to eq({
				"text" => "Comment Text",
				"username" => "dks"
			})
		end

		it 'returns an empty JSON obj if there are no comments' do
			got_json = @post.get_comments_json
			expect(got_json).to eq({})
		end
	end
end
