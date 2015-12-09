class Product < ActiveRecord::Base
  belongs_to :robot 
  has_and_belongs_to_many :categories
  has_many :reviews
end
