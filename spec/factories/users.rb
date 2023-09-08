FactoryBot.define do
  factory :user do
    name { 'Mr. User' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
  end
end
