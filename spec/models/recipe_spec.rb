require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with valid attributes' do
    recipe = FactoryBot.build(:recipe, user:)
    expect(recipe).to be_valid
  end

  it 'is invalid without a name' do
    recipe = FactoryBot.build(:recipe, user:, name: nil)
    expect(recipe).to_not be_valid
  end

  it 'is invalid without a description' do
    recipe = FactoryBot.build(:recipe, user:, description: nil)
    expect(recipe).to_not be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many recipe_foods' do
    association = described_class.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end

  it 'has many foods through recipe_foods' do
    association = described_class.reflect_on_association(:foods)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:recipe_foods)
  end

  it 'has a toggle_privacy! method' do
    recipe = FactoryBot.create(:recipe, user:)
    expect(recipe).to respond_to(:toggle_privacy!)
  end

  it 'toggles the privacy attribute' do
    recipe = FactoryBot.create(:recipe, user:, public: true)
    recipe.toggle_privacy!
    expect(recipe.public).to be_falsey
  end

  it 'has a food_quantity method' do
    recipe = FactoryBot.create(:recipe, user:)
    expect(recipe).to respond_to(:food_quantity)
  end

  it 'calculates the correct food quantity' do
    user = FactoryBot.create(:user)
    food1 = FactoryBot.create(:food, user:)
    recipe = FactoryBot.create(:recipe, user:)
    FactoryBot.create(:recipe_food, recipe:, food: food1, quantity: 2)
    expect(recipe.food_quantity).to eq(2)
  end

  it 'has a total_price method' do
    recipe = FactoryBot.create(:recipe, user:)
    expect(recipe).to respond_to(:total_price)
  end

  it 'calculates the correct total price' do
    user = FactoryBot.create(:user)
    food1 = FactoryBot.create(:food, user:, price: 5.0)
    recipe = FactoryBot.create(:recipe, user:)
    FactoryBot.create(:recipe_food, recipe:, food: food1, quantity: 2)
    expect(recipe.total_price).to eq(10.0)
  end

  it 'has a scope for public recipes' do
    public_recipe1 = FactoryBot.create(:recipe, user:, public: true)
    public_recipe2 = FactoryBot.create(:recipe, user:, public: true)
    FactoryBot.create(:recipe, user:, public: false)

    expect(Recipe.public_recipes).to match_array([public_recipe1, public_recipe2])
  end
end
