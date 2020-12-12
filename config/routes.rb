Rails.application.routes.draw do
  get 'items/index'
  devise_for :users,controllers: {
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :users, only: %i[edit update show]
  resources :items

end
