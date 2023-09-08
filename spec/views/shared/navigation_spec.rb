require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Navigation Bar', type: :feature do
  include LoginHelper

  context 'when user is signed in' do
    scenario 'displays navigation links and sign out button' do
      user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
      log_in(user)

      visit root_path

      expect(page).to have_link('My Recipes', href: my_recipes_path)
      expect(page).to have_link('Public Recipes', href: public_recipes_path)
      expect(page).to have_link('Add Recipe', href: new_recipe_path)
      expect(page).to have_button('Sign Out')
    end
  end

  context 'when user is not signed in' do
    scenario 'does not display navigation links and sign out button' do
      visit root_path

      expect(page).not_to have_link('My Recipes', href: my_recipes_path)
      expect(page).not_to have_link('Public Recipes', href: public_recipes_path)
      expect(page).not_to have_link('Add Recipe', href: new_recipe_path)
      expect(page).not_to have_button('Sign Out')
    end
  end
end
