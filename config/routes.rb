# frozen_string_literal: true

Rails.application.routes.draw do

  resources :styles do
    get 'about', on: :collection
  end

  resources :styles
  resources :beer_clubs
  resources :beers
  
  resources :memberships do
    post 'confirm', on: :member
  end

  resources :users do
    post 'toggle_activity', on: :member
  end
  
  resources :breweries do
    post 'toggle_activity', on: :member
  end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'breweries#index'

  resources :ratings, only: %i[index new create destroy show]

  get 'signup', to: 'users#new'
  
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only: [:index, :show]
  # mikä generoi samat polut kuin seuraavat kaksi
  # get 'places', to: 'places#index'
  # get 'places/:id', to: 'places#show'
  post 'places', to: 'places#search'

  get 'beerlist', to: 'beers#list'
end
