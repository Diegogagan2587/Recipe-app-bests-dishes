Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show]
  resources :foods, only: [:index, :show, :new, :create] do
    delete 'delete_food', on: :member
  end
end
