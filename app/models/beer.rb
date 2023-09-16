class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		rates = ratings.map { |r| r.score }
		rates.sum.to_f / ratings.count.to_f
	end

end
