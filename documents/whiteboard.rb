def build_comments_nest(post)
	post.comments.map do |comment|
		build_comment_json(comment)
	end
end

def build_comment_json(comment)
	obj = { "text" => comment.text,
					"username" => comment.user.username }
	if comment.comments.count > 0
		obj["comments"] = build_comments_nest(comment)
	end
	obj
end

=begin
[
	{ text: 'blah',
		user: 'blah' },
	{ text: 'blah',
		user: 'blah',
		comments: [
			{ text: 'blah',
				user: 'blah' 
				comments: [
					{ text: 'blah',
						user: 'blah' }
				]
			},
			{ text: 'blah',
			user: 'blah' }
		]
	},
	{ text: 'blah',
		user: 'blah' },
	{ text: 'blah',
		user: 'blah' }
]
=end