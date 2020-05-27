FactoryBot.define do
  factory :contact do
    name { Faker::Lorem.characters(number:6) }
    email { Faker::Internet.email }
    body { Faker::Lorem.characters(number:10) }
  end
end