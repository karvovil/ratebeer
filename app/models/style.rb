class Style < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(num)
    sorted_by_rating_in_desc_order = Style.all.sort_by(&:average_rating)
    sorted_by_rating_in_desc_order.last(num).reverse
  end
end
