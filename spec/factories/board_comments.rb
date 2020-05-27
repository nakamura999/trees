FactoryBot.define do
  factory :board_comment do
    comment { Faker::Lorem.characters(number:30) }
    user
    board
  end
end