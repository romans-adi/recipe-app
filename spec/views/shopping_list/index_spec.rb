require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Shopping List', type: :feature, js: true do
  include LoginHelper

  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  scenario 'User views the shopping list' do
    user = create(:user)
    recipe = create(:recipe)
    recipe_food = create(:recipe_food, recipe:)

    log_in(user)
    visit shopping_list_path(recipe_id: recipe.id)
    expect(page).to have_content('Shopping List')
    expect(page).to have_css('#amount', visible: true)
    expect(page).to have_css('#total', visible: true)
    expect(page).to have_selector('table#ingredients')
    expect(page).to have_selector('thead th#food')
    expect(page).to have_selector('thead th#quantity')
    expect(page).to have_selector('thead th#price')
    expect(page).to have_content(recipe_food.food.name)
    expect(page).to have_content(recipe_food.quantity)
    expect(page).to have_content(number_to_currency(recipe_food.calculated_price, unit: '$'))
  end
end
