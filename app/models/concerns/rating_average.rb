module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    if ratings.empty?
      0
    else
      rates = ratings.map(&:score)
      rates.sum.to_f / ratings.count
    end
  end
end
