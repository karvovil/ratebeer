module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    if ratings.length > 0
      rates = ratings.map(&:score)
      rates.sum.to_f / ratings.count
    else
      0
    end
  end
end
