require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  scenario 'user signs up with valid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'johndoe@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'user signs up with invalid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Email can\'t be blank')
  end
end
