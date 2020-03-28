# Create the following:
# - 2 users
# - 6 items with the following logic:
#     - 3 items per user.
#     - 2 items with tag 'one'
#     - 2 items with tag 'two'
#     - 2 items without tag.
user1 = FactoryBot.create(:user, email: 'test@test.com')
user2 = FactoryBot.create :user

[user1, user2].map do |user|
  ['one', 'two', nil].map do |tag|
    item = FactoryBot.build(:item, {user: user})
    user.tag(item, with: tag, on: :tags)
  end
end
