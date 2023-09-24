class Style < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |a| a.average_rating }
    sorted_by_rating_in_desc_order.last(3).reverse
  end
end
