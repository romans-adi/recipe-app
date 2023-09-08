require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Add a New Ingredient', type: :feature do
  include LoginHelper

  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }

  before do
    log_in(user)
    @food = create(:food, name: 'Sample Food', measurement_unit: 'Unit 1', price: 10.0)
    visit new_recipe_recipe_food_path(recipe)
  end

  scenario 'User adds a new ingredient' do
    select @food.name, from: 'recipe_food[food_id]'
    fill_in 'recipe_food[quantity]', with: 3
    click_button 'Add ingredient'

    expect(page).to have_content('Ingredient created successfully')
    expect(page).to have_content(@food.name)
    expect(page).to have_content('3')
    expect(page).to have_content('$30.00')
  end
end
