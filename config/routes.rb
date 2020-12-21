Rails.application.routes.draw do
  get 'comments/new'
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/homes/guest_sign_in', to: 'homes#new_guest'
  post '/homes/guest2_sign_in', to: 'homes#new_guest2'
  root 'homes#index'
  get 'items/search'
  get 'items/sort'
  resources :users, only: %i[edit update show]
  get 'items/stock'
  get  'items/receipt'
  resources :tickets,only: %i[index show]
  resources :favorites,only: %i[index]
  resources :items do
    post  'tickets/confirmation'
    post 'stock_out'
    resource :favorites,only: %i[create destroy]
    get :favorites, on: :collection
    resources :comments,only: %i[new create]
    resources :tickets,except: %i[index show]
  end

end
