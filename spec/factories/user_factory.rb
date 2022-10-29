FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { Faker::Internet.unique.email }
    password { 'valid_password' }
  end
end
