Rails.application.routes.draw do
  devise_for :users , controllers: { registrations: 'registrations' }
  root "users#index"
  get '/home', to: 'home#index'
  resources :users, only: [:index, :show]
  resources :recipes, only: %i[index show new create destroy]
  resources :recipe_foods, only: %i[new create destroy]
  get '/public_recipe', to: 'recipes#public_recipe', as: 'public_recipe'
  resources :foods, only: [:index, :show, :new, :create] do
    delete 'delete_food', on: :member
  end
  resources :general_shopping_list, only: [:index ]
end
