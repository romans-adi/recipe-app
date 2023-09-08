require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(nil)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns the current user\'s foods to @foods' do
      get :index
      expect(assigns(:foods)).to eq(user.foods)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new food to @food' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end

    it 'assigns measurement units to @measurement_units' do
      get :new
      expect(assigns(:measurement_units)).to be_an(Array)
    end
  end

  describe 'POST #create' do
    it 'creates a new food with valid parameters' do
      food_params = FactoryBot.attributes_for(:food, user:)
      expect do
        post :create, params: { food: food_params }
      end.to change(Food, :count).by(1)
      expect(response).to redirect_to(foods_path)
      expect(flash[:notice]).to be_present
    end

    it 'does not create a new food with invalid parameters' do
      invalid_food_params = FactoryBot.attributes_for(:food, user:, name: nil)
      expect do
        post :create, params: { food: invalid_food_params }
      end.not_to change(Food, :count)
      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested food' do
      food = FactoryBot.create(:food, user:)
      expect do
        delete :destroy, params: { id: food.id }
      end.to change(Food, :count).by(-1)
      expect(response).to redirect_to(foods_path)
    end
  end
end
