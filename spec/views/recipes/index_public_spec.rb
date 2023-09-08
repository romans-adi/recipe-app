require 'rails_helper'
require_relative '../support/authorization_helper'

RSpec.feature 'Recipes', type: :feature, js: true do
  include LoginHelper
  let(:user) { create(:user) }

  scenario 'displaying public recipes when they exist' do
    public_recipes = create_list(:recipe, 3, public: true)

    log_in(user)
    visit public_recipes_path
    expect(page).to have_content('Public Recipes')

    public_recipes.each do |recipe|
      within(all('.bg-black.bg-opacity-50')[public_recipes.index(recipe)]) do
        expect(page).to have_link(recipe.name, href: recipe_path(recipe.id))
        expect(page).to have_content("By #{recipe.user.name}")
        expect(page).to have_content("Food Quantity: #{recipe.food_quantity}")
        expect(page).to have_content("Total Price: #{number_to_currency(recipe.total_price, unit: '$')}")
      end
    end
  end

  scenario 'displaying a message when there are no public recipes' do
    log_in(user)
    visit public_recipes_path
    expect(page).to have_content('There is no public recipe.')
  end
end
