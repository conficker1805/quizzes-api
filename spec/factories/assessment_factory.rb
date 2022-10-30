FactoryBot.define do
  factory :assessment do
    association :user
    association :domain

    before(:create) do |assessment, _evaluator|
      quizzes = Quizzes::RandomQuery.new(assessment.domain).call
      assessment.expectation = Quizzes::RightAnswerService.new(quizzes).call
    end
  end
end
