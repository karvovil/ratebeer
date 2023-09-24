class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, presence: true
  validate :year_cannot_be_in_future, on: :create

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def year_cannot_be_in_future
    return unless year > Date.today.year || year < 1040

    errors.add(:year, "can't be in the future or past")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  def to_s
    name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |a| a.average_rating }
    sorted_by_rating_in_desc_order.last(3).reverse
  end
end
