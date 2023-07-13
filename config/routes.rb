# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments
  end
  # Defines the root path route ("/")
  root 'welcome#index'

  get :login, to: "authentication#login"
  post :login, to: "authentication#search"
end
