Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  get '/home', to: 'home#index'
  resources :users, only: [:index, :show]
  resources :recipes, only: %i[index show new create destroy]
  get '/public_recipe', to: 'recipes#public_recipe', as: 'public_recipe'
end
