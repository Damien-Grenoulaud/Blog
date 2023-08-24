# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments
  end
  # Defines the root path route ("/")
  root 'welcome#index'

  get :login, to: "authentication#login"
  delete :logout, to: "authentication#logout"
  post :login, to: "authentication#search"
  get :dashboard, to: "dashboard#index"
  

  namespace :dashboard do
    resources :articles do
      put :change_status
    end
  end
end
