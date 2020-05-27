FactoryBot.define do
  factory :board do
    title { Faker::Lorem.characters(number:6) }
    content { Faker::Lorem.characters(number:20) }
    user
  end
end