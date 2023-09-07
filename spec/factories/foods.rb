FactoryBot.define do
  factory :food do
    name { 'Sample Food' }
    price { 10.0 }
    quantity { 1 }
    association :user, factory: :user
  end
end
