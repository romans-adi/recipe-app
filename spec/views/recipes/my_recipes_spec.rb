require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.describe 'My Recipes Page', type: :feature do
  include LoginHelper
  context 'when user has recipes' do
    before do
      user = create(:user)
      create_list(:recipe, 3, user:)
      log_in(user)
      visit my_recipes_path
    end

    it 'displays a list of recipes' do
      expect(page).to have_content('Test Recipe')
      expect(page).to have_content('Recipe description')
    end

    it 'displays a remove button for each recipe' do
      expect(page).to have_button('Remove', count: 3)
    end
  end
end
