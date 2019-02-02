# 15.times do
#   User.create(
#     username: Faker::Friends.character, password: 'hi', avatar: Faker::Fillmurray.image, bio: Faker::Friends.quote
#   )

User.create(username: 'test', password: '123')


end
