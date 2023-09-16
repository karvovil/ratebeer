module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    rates = ratings.map(&:score)
    rates.sum.to_f / ratings.count
  end
end
