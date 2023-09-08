require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Food Management', type: :feature do
  include LoginHelper

  scenario 'User adds a new food' do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    log_in(user)
    visit new_food_path

    expect(page).to have_content('Add a new food')

    fill_in 'Name', with: 'Apple'
    select 'grams', from: 'food_measurement_unit', wait: 10
    fill_in 'Price', with: 5.0

    click_button 'Add food'
    sleep 5
    expect(page).to have_content('Apple')
    expect(page).to have_content('grams')
    expect(page).to have_content('$5.00')
  end
end
