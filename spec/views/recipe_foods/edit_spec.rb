require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Edit Quantity', type: :feature do
  include LoginHelper

  scenario 'User edits the quantity of a recipe food' do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    log_in(user)
    recipe = create(:recipe, user:)
    initial_quantity = 5
    recipe_food = create(:recipe_food, recipe:, quantity: initial_quantity)

    visit edit_recipe_recipe_food_path(recipe, recipe_food)

    expect(page).to have_content('Edit quantity')

    new_quantity = 10
    fill_in 'Quantity', with: new_quantity
    click_button 'Update quantity'

    expect(page).to have_content('Quantity updated successfully')
    within('.grid') do
      expect(page).to have_content(new_quantity)
    end
  end
end
