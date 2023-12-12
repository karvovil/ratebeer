# Ratebeer
Beer application made in Open university RoR -course

[![Maintainability](https://api.codeclimate.com/v1/badges/909eda280ba61ac7090e/maintainability)](https://codeclimate.com/github/karvovil/ratebeer/maintainability)

## Deployment
Currently deployed at https://rate-my-beer.fly.dev

Most of the Hotwire stuff is not yet working in deployment so some errors are to be expected

Deployment to fly.io is straightforward with `fly deploy`


## ENV -variables to set
BEERMAPPING_APIKEY from beermapping.com

WEATHERSTACK_APIKEY from weatherstack.com

## Scripts
#### `rails s`
starts the server
#### `rubocop -a`
runs linter
#### `rspec spec`
runs tests
#### `rails db:create`
creates database
#### `rails db:migrate`
migrates database
#### `rails db:rollback`
cancels the migration
#### `rails db:seed`
seeds the database from db/seeds.rb
#### `rails db:reset`
removes all data from db

## Versions 
Ruby 3.2.2

Rails 7.0.8

Rspec 3.12
