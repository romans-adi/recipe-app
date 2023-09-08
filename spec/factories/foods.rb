FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "Food #{n}" }
    sequence(:measurement_unit) { |n| "Unit #{n}" }
    price { 10.0 }
    quantity { 1 }
    association :user, factory: :user
  end
end
