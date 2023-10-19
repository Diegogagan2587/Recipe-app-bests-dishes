Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root "users#index"
  get '/home', to: 'home#index'
  resources :users, only: [:index, :show]
  resources :recipe_foods, only: %i[new create destroy]
  resources :recipes, only: %i[index show new create destroy] do
    member do
      patch 'toggle_public'
    end
    
  end
  get '/public_recipe', to: 'recipes#public_recipe', as: 'public_recipe'
  resources :foods, only: [:index, :show, :new, :create] do
    delete 'delete_food', on: :member
  end
end
