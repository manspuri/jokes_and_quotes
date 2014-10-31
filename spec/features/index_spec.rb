require 'rails_helper'

feature "the index" do
	scenario "a user can see a post" do
		post = Post.create(user_id: 1, post_type: "jok", text: "What are Mario's favorite type of pants? A. Denim denim denim", created_at: Time.now, updated_at: Time.now)
		visit ('/')
	assert page.has_content?(post.text)
	end
end