Rails.application.routes.draw do
  root to: 'home#index'
  get '/recordCheck', to: 'home#index'

  namespace :api, format: 'json' do
    resources :users, only: [:index, :create, :update]
  end

  namespace :api, format: 'json' do
    resources :records, only: [:index, :create, :update]
  end
end
