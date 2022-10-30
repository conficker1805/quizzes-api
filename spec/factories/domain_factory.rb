FactoryBot.define do
  factory :domain do
    name { Faker::App.name }

    trait :with_quizzes do
      after(:create) do |domain, _evaluator|
        create_list(:quiz, 20, domain: domain)
      end
    end
  end
end
