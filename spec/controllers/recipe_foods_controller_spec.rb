require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, recipe:, food:) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(nil)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'assigns the necessary variables' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to render_template :new
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:available_foods)).to eq(Food.all)
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe food with valid parameters' do
      expect do
        post :create, params: { recipe_id: recipe.id, recipe_food: { food_id: food.id, quantity: 2 } }
      end.to change(RecipeFood, :count).by(1)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Ingredient created successfully')
    end

    it 'does not create a new recipe food with invalid parameters' do
      expect do
        post :create, params: { recipe_id: recipe.id, recipe_food: { food_id: food.id, quantity: -1 } }
      end.not_to change(RecipeFood, :count)

      expect(response).to render_template :new
      expect(flash[:alert]).to eq('Quantity must be a positive number.')
    end
  end

  describe 'GET #edit' do
    it 'assigns the necessary variables' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to render_template :edit
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:recipe_food)).to eq(recipe_food)
    end
  end

  describe 'PATCH #update' do
    it 'updates the recipe food with valid parameters' do
      patch :update, params: { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { quantity: 3 } }

      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Quantity updated successfully')
      expect(recipe_food.reload.quantity).to eq(3)
    end

    it 'does not update the recipe food with invalid parameters' do
      put :update, params: { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { quantity: '0' } }
      expect(flash[:alert]).to eq('Quantity must be a positive number')
      expect(response).to redirect_to(edit_recipe_recipe_food_path(recipe, recipe_food))
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the recipe food' do
      recipe_food = create(:recipe_food, recipe:)
      expect do
        delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      end.to change(RecipeFood, :count).by(-1)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Ingredient deleted')
    end

    it 'handles the case where the recipe food is not found' do
      delete :destroy, params: { recipe_id: recipe.id, id: 999 }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:alert]).to eq('Ingredient not found')
    end
  end
end
