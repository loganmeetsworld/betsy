require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @good_product = Product.create(name: 'product', price: 10, robot_id: 1, stock: 1)
    @bad_product = Product.create(name: nil, price: nil, robot_id: nil, stock: nil)
    @negative_nums = Product.create(name: 'product', price: -10, robot_id: 1, stock: -1)
  end

  describe "validations" do 
    it "has a user id" do 
      expect(@good_product).to be_valid
      expect(@bad_product).to_not be_valid
    end

    it "has a name" do
      expect(@good_product).to be_valid
      expect(@bad_product).to_not be_valid
      expect(@bad_product.errors.keys).to include(:name)
    end

    it "has a robot_id" do
      expect(@bad_product.errors.keys).to include(:robot_id)
    end

    it "has a price" do
      expect(@bad_product.errors.keys).to include(:price)
    end

    it "price must be greater than 0" do
      expect(@negative_nums.errors.keys).to include(:price)
    end

    it "has a stock" do
      expect(@bad_product.errors.keys).to include(:stock)
    end

    it "stock must be greater than 0" do
      expect(@negative_nums.errors.keys).to include(:stock)
    end
  end
end
