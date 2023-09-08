require 'rails_helper'

RSpec.describe ShoppingListController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'fetches the recipe, recipe foods, and general shopping list' do
      recipe_food1 = create(:recipe_food, recipe:)
      recipe_food2 = create(:recipe_food, recipe:)
      get :index, params: { recipe_id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:recipe_foods)).to include(recipe_food1, recipe_food2)
      expect(assigns(:general_shopping_list)).not_to be_nil
      expect(assigns(:total)).not_to be_nil
    end

    it 'sorts the shopping list by name in ascending order by default' do
      food1 = create(:food, user:, name: 'Banana')
      food2 = create(:food, user:, name: 'Apple')
      recipe_food1 = create(:recipe_food, recipe:, food: food1)
      recipe_food2 = create(:recipe_food, recipe:, food: food2)
      get :index, params: { recipe_id: recipe.id }
      expect(assigns(:recipe_foods)).to eq([recipe_food2, recipe_food1])
    end

    it 'sorts the shopping list by the selected column and direction' do
      food1 = create(:food, user:, name: 'Banana')
      food2 = create(:food, user:, name: 'Apple')
      recipe_food1 = create(:recipe_food, recipe:, food: food1, quantity: 5, calculated_price: 10.0)
      recipe_food2 = create(:recipe_food, recipe:, food: food2, quantity: 3, calculated_price: 6.0)
      get :index, params: { recipe_id: recipe.id, sort: 'price', direction: 'desc' }
      expect(assigns(:recipe_foods)).to eq([recipe_food1, recipe_food2])
    end
  end
end
