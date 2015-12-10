class Product < ActiveRecord::Base
  belongs_to :robot 
  has_and_belongs_to_many :categories
  has_many :reviews

  def self.rating_average(product)
    sums = []
    product.reviews.each do |review|
      sums.push(review.rating)
    end
    return sums.inject(:+) / product.reviews.count
  end

  def self.show_categories(product)
    product.categories.map {|category| category.name}.join(", ")
  end
end
