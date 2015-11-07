Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :favorites, only: [:create]
  end
  resources :gifs, only: [:index]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :gifs, except: [:show, :update]
  end
end
