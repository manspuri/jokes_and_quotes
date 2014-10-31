require 'rails_helper'

describe Post do
	it "should have text"	do
		text = "Why don't they have gambling in Africa? Too many cheetahs"
		p = Post.new(text: text)
		expect(p.text).to eq text
	end
end
