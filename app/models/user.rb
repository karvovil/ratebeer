class User < ApplicationRecord
  include RatingAverage

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings
  has_many :beers, through: :ratings

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
end
