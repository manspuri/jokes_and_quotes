# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first

duke = User.create(first_name: "Duke", last_name: "Green", email: "dkgreene@devbootcamp.com", username: "thiiird_person", password_hash: "password")

duke.posts.create!(post_type: "Joke", text: "If you're looking for sympathy, you can find it in the dictionary between \"shit\" and \"syphillis\"")