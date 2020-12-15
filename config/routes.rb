Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'items/search'
  resources :users, only: %i[edit update show]
  get 'items/stock'
  resources :items do
    post 'stock_out'
  end

end
