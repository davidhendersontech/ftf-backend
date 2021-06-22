Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'
  post 'users/createtoken', to: 'users#createtoken'
end
