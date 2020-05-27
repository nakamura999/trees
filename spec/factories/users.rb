FactoryBot.define do
  factory :user do
  	# number:10 10桁の数字をランダムに作成。
    name { Faker::Lorem.characters(number:10) }
    kana_name { Faker::Lorem.characters(number:10) }
    nickname { Faker::Lorem.characters(number:10) }
    prefectures { Faker::Lorem.characters(number:4) }
    email { Faker::Internet.email }
    body { Faker::Lorem.characters(number:20) }
    status { "美容師" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end