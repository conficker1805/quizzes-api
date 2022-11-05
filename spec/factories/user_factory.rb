FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { Faker::Internet.unique.email }
    password { 'valid_password' }
    token_issued_at { 1.hour.ago }
  end
end
