FactoryBot.define do
  factory :quiz do
    kind { :single_choice }
    state { :active }
    content { Faker::Lorem.paragraph }
    association :domain

    after(:create) do |quiz, _evaluator|
      # Create 4 answers for this question. One of them is the correct answer
      create(:answer, quiz: quiz, correct: true)
      create_list(:answer, 3, quiz: quiz, correct: false)
    end
  end
end
