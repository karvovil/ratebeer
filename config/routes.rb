Rails.application.routes.draw do
  resources :beers
  resources :breweries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'breweries#index'

  get 'ratings', to: 'ratings#index'
end
