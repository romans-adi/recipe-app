require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Recipe Management', type: :feature do
  include LoginHelper

  scenario 'User adds a new recipe' do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    log_in(user)
    visit new_recipe_path(user)
    recipe = create(
      :recipe,
      name: 'Test Recipe',
      description: 'Recipe description',
      preparation_time: 30,
      cooking_time: 45
    )
    recipe_id = recipe.id

    expect(page).to have_content('Add a Recipe')

    fill_in 'Name', with: 'Test Recipe'
    fill_in 'Description', with: 'Recipe description'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '45'
    check 'Public'

    click_button 'Create Recipe'
    expect(page).to have_content('Recipe created')
    visit recipe_path(recipe_id)
    expect(page).to have_content('Test Recipe')
    expect(page).to have_content('Recipe description')
    expect(page).to have_content('Preparation time: 30 mins')
    expect(page).to have_content('Cooking time: 45 mins')
    expect(page).to have_content('Public')
  end
end
