class User < ApplicationRecord
  include RatingAverage

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validate :password_has_number_and_capital, on: :create

  def password_has_number_and_capital
    return if password.match(/(?=.*[0-9])(?=.*[0-9])/)

    errors.add(:password, "needs a number and a capital")
  end
end
