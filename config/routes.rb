Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
  }

  devise_scope :user do
    root to: 'devise/sessions#new', as: :login
    root to: 'devise/registrations#new', as: :sign_up
  end

  root 'recipes#my_recipes'

  resources :recipes, only: [:new, :create, :index, :show, :destroy, :put] do
    resources :shopping_list, only: [:index]
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update] do
      collection do
        get 'list'
      end
    end
  end
  resources :foods, only: [:index, :new, :create, :destroy]

  get '/recipes/:id/general_shopping_list/:column', to: 'recipes#general_shopping_list', as: 'general_shopping_list'
  put '/recipes/:id/toggle_privacy', to: 'recipes#toggle_privacy', as: 'toggle_recipe_privacy'
  get 'my_recipes', to: 'recipes#my_recipes'
  get '/recipes/:recipe_id/shopping_list', to: 'shopping_list#index', as: 'shopping_list'
  get '/public_recipes', to: 'recipes#index_public', as: 'public_recipes'
end
