class Product < ActiveRecord::Base
  belongs_to :robot
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :orderitems

  validates :name, presence: true
  validates :robot_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, numericality: {greater_than_or_equal_to: 0}
  validates :length, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 108 }
  validates :width, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 165 }
  validates :height, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 165 }
  validates :weight, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 2400 }

  def rating_average
    sums = []
    self.reviews.each do |review|
      sums.push(review.rating)
    end
    return sums.inject(:+) / self.reviews.count
  end

  def show_categories
    self.categories.map { |category| category.name.capitalize }.join(", ")
  end

  def self.search(query)
    where("name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
  end
end
