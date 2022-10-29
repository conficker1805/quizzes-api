FactoryBot.define do
  factory :domain do
    name { Faker::App.name }
  end
end
