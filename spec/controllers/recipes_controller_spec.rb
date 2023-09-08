require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }

  before do
    sign_in user
  end

  describe 'GET #my_recipes' do
    it 'returns a successful response' do
      get :my_recipes
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response for an existing recipe' do
      get :show, params: { id: recipe.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index_public' do
    it 'returns a successful response' do
      get :index_public
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe' do
      expect do
        post :create, params: { recipe: { name: 'New Recipe', description: 'Description' } }
      end.to change(Recipe, :count).by(1)

      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq('Recipe created')
    end

    it 'does not create a recipe with invalid data' do
      expect do
        post :create, params: { recipe: { name: '' } }
      end.not_to change(Recipe, :count)

      expect(response).to have_http_status(:success)
      expect(flash[:alert]).to eq('Recipe not created')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a recipe with public set to true' do
      recipe = create(:recipe, user:, public: true)
      expect do
        delete :destroy, params: { id: recipe.id }
      end.to change(Recipe, :count).by(-1)
    end
  end

  describe 'GET #toggle_privacy' do
    it 'toggles the privacy setting of a recipe' do
      recipe = create(:recipe, user:, public: true)
      get :toggle_privacy, params: { id: recipe.id }
      recipe.reload
      expect(recipe.public).to eq(false)
      expect(response).to redirect_to(recipe_path(recipe))
    end
  end
end
