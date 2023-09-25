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
    return if password&.match(/(?=.*[0-9])(?=.*[0-9])/)

    errors.add(:password, "needs a number and a capital")
  end

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole

    ratings.max_by(&:score).beer
    # OR ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    return nil if ratings.empty?

    grouped_rates = ratings.group_by { |r| r.beer.style.name }
    style_scores = grouped_rates.map { |k, v| [k, v.map(&:score).sum] }
    style_scores.max_by{ |_k, v| v }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    breweries = ratings.map { |r| r.beer.brewery }
    breweries.uniq.max_by(&:average_rating)
  end

  def self.top(num)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |a| a.ratings.count }
    sorted_by_rating_in_desc_order.last(num).reverse
  end
end
