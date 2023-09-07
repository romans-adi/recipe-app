require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, food:, recipe:) }

  it 'has quantity' do
    expect(recipe_food.quantity).to be_present
  end

  it 'has food' do
    expect(recipe_food.food).to be_present
  end

  it 'has recipe' do
    expect(recipe_food.recipe).to be_present
  end

  it 'has a quantity that is a positive integer' do
    recipe_food = FactoryBot.build(:recipe_food, quantity: 5)
    expect(recipe_food).to be_valid
  end

  it 'is invalid with a non-positive integer quantity' do
    recipe_food = FactoryBot.build(:recipe_food, quantity: -2)
    expect(recipe_food).to_not be_valid
  end

  it 'is invalid with a non-integer quantity' do
    recipe_food = FactoryBot.build(:recipe_food, quantity: 2.5)
    expect(recipe_food).to_not be_valid
  end
end
