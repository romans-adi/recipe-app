require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Recipe Details', type: :feature do
  include LoginHelper

  scenario 'User views recipe details' do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    log_in(user)
    recipe = create(:recipe, user:, name: 'Test Recipe', description: 'Recipe description', preparation_time: 30, cooking_time: 45)
    food1 = create(:food, name: 'Food 1', price: 10.0)
    food2 = create(:food, name: 'Food 2', price: 15.0)
    create(:recipe_food, recipe:, food: food1, quantity: 5)
    create(:recipe_food, recipe:, food: food2, quantity: 3)

    visit recipe_path(recipe.id)

    expect(page).to have_content('Recipe Name: Test Recipe')
    expect(page).to have_content('Preparation time: 30 mins')
    expect(page).to have_content('Cooking time: 45 mins')
    expect(page).to have_content('Recipe description')
    expect(page).to have_content('Generate shopping list')
    expect(page).to have_link('Add ingredient')

    expect(page).to have_content('Food')
    expect(page).to have_content(/Quantity/i)
    expect(page).to have_content(/Value/i)
    expect(page).to have_content(/Actions/i)

    expect(page).to have_content('Food 1')
    expect(page).to have_content('5')
    expect(page).to have_content('$50.00')
    expect(page).to have_content('Food 2')
    expect(page).to have_content('3')
    expect(page).to have_content('$45.00')
  end
end
