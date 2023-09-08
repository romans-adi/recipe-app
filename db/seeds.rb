require 'faker'

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: 'user'
  )
end

10.times do
  Food.create!(
    name: Faker::Food.unique.ingredient,
    measurement_unit: Faker::Food.metric_measurement,
    quantity: Faker::Number.between(from: 1, to: 100),
    price: Faker::Number.decimal(l_digits: 2)
  )
end

10.times do
  user = User.all.sample
  recipe = Recipe.create!(
    name: Faker::Food.dish,
    preparation_time: Faker::Number.between(from: 5, to: 120),
    cooking_time: Faker::Number.between(from: 5, to: 120),
    description: Faker::Lorem.paragraph,
    public: [true, false].sample,
    user: user
  )

  3.times do
    food = Food.all.sample
    RecipeFood.create!(
      quantity: Faker::Number.between(from: 1, to: 10),
      food: food,
      recipe: recipe
    )
  end
end
