Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :games, only: [ :index, :show, :new, :create ] do
    resources :bookings, only: [ :new, :create, :show, :index ]
  end
  resources :bookings
  get 'admin', to: 'bookings#admin_index'
end
