# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first

=begin
create 20 users
foreach user make 1-5 posts
foreach post make 5-20 comments
foreach comment (recursive) make 0-2 comments
=end

require 'faker'

TYPES = ['joke', 'quote']

users = (1..20).to_a.map do
	User.create!(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.email,
		username: "#{Faker::Internet.user_name} #{rand(10_000)}",
		password: 'password'
	)
end

# how to add records with polymorphic association
# how to retrieve records with polymorphic association

users.each do |user|
	(rand(5) + 1).times do
		Post.create!(
			user: user,
			post_type:	TYPES.sample,
			text: Faker::Company.catch_phrase
		)
	end
end

Post.all.each do |post|
	(rand(16) + 5).times do
		Comment.create!(
			user: users.sample,
			commentable_id:	post.id,
			commentable_type: 'Post',
			text: Faker::Company.catch_phrase
		)
	end
end

comment_stack = []
Comment.all.each do |comment|
	rand(3).times do
		sub_comment = Comment.create!(
			user: users.sample,
			commentable_id:	comment.id,
			commentable_type: 'Comment',
			text: Faker::Company.catch_phrase
		)
		comment_stack << sub_comment
	end
end

while comment_stack.count > 0
	comment = comment_stack.pop
	rand(2).times do
		sub_comment = Comment.create!(
			user: users.sample,
			commentable_id:	comment.id,
			commentable_type: 'Comment',
			text: Faker::Company.catch_phrase
		)
		comment_stack << sub_comment
	end
end

