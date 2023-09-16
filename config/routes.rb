# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'breweries#index'

  resources :ratings, only: %i[index new create destroy]

  get 'signup', to: 'users#new'
  
  resource :session, only: [:new, :create, :destroy]

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
end
