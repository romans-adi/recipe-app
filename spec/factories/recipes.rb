FactoryBot.define do
  factory :recipe do
    name { 'Test Recipe' }
    description { 'Recipe description' }
    association :user, factory: :user
  end
end
