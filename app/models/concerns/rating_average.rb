module RatingAverage
  extend ActiveSupport::Concern
    def average_rating
	  	rates = ratings.map { |r| r.score }
	  	rates.sum.to_f / ratings.count.to_f
	  end
 end