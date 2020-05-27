FactoryBot.define do
  factory :salon do
    salon_name { Faker::Lorem.characters(number:8) }
    salon_address { Faker::Lorem.characters(number:8) }
    salon_phone { Faker::PhoneNumber.characters(number:10) }
    user
  end
end