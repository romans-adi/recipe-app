require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Food Management', type: :feature do
  include LoginHelper

  scenario 'User views the list of foods and adds a new food' do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    log_in(user)
    visit new_food_path
    fill_in 'Name', with: 'Apple'
    select 'grams', from: 'food_measurement_unit', wait: 5
    fill_in 'Price', with: 5.0

    click_button 'Add food'
    visit new_food_path

    fill_in 'Name', with: 'Banana'
    select 'grams', from: 'food_measurement_unit', wait: 5
    fill_in 'Price', with: 10.0

    click_button 'Add food'

    visit foods_path

    expect(page).to have_text('Apple')
    expect(page).to have_text('grams')
    expect(page).to have_text('$5.00')

    expect(page).to have_text('Banana')
    expect(page).to have_text('grams')
    expect(page).to have_text('$10.00')
  end
end
