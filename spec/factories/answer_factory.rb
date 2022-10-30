FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.sentence }
    correct { false }
    association :quiz
  end
end
