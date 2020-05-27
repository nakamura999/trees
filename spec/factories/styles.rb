FactoryBot.define do
  factory :style do
    name { Faker::Lorem.characters(number:5) }
    content { Faker::Lorem.characters(number:20) }
    color_style { Faker::Lorem.characters(number:5) }
    menu { Faker::Lorem.characters(number:5) }
    price { Faker::Number.number(digits: 6) }
    status { "MENS" }
    user
    jenre
  end
end