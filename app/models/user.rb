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
    return if password && password.match(/(?=.*[0-9])(?=.*[0-9])/)

    errors.add(:password, "needs a number and a capital")
  end

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole

    ratings.sort_by{ |r| r.score }.last.beer
    # OR ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    return nil if ratings.empty?

    rates = ratings.group_by {|r| r.beer.style}
    asdf = rates.map { |k, v| [k, (v.map &:score).sum] }
    asdf.sort_by{ |_k, v| v }.last.first
  end
end
