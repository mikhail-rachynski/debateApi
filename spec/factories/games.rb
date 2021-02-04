FactoryBot.define do
  factory :game do
    topic { Faker::Lorem.word }
    status { 0 }
  end
end