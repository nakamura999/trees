FactoryBot.define do
  factory :jenre do
    name { Faker::Lorem.characters(number:6) }
  end
end