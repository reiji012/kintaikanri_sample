Rails.application.routes.draw do
  root to: 'home#index'
  get '/recordCheck', to: 'home#index'
  get '/userRegistration', to: 'home#index'
  get '/login', to: 'home#index'
  post '/login', to: 'sessions#create'
  get '/userEdit', to: 'home#index'

  namespace :api, format: 'json' do
    resources :users, only: [:index, :create, :update, :destroy]
  end

  namespace :api, format: 'json' do
    resources :records, only: [:index, :create, :update, :destroy]
  end
end
