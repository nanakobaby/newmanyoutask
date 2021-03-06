Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end
end
