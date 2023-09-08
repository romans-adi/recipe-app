require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
  scenario 'user logs in with valid credentials' do
    create(:user, email: 'test@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Login'
    expect(page).to have_button('Sign Out')
  end

  scenario 'user logs in with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Login'
    expect(page).to have_content('Invalid Email or password')
  end
end
