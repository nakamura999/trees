FactoryBot.define do
  factory :style do
    name { Faker::Lorem.characters(number:5) }
    content { Faker::Lorem.characters(number:20) }
    color_style { Faker::Lorem.characters(number:5) }
    menu { Faker::Lorem.characters(number:5) }
    user
  end
end