FactoryBot.define do
  factory :item do
    link { Faker::Internet.url }
    user
  end
end
