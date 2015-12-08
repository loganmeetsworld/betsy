class Product < ActiveRecord::Base
  belongs_to :robot 
  belongs_to :category
  has_many :reviews
end
