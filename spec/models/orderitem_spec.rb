require 'rails_helper'

RSpec.describe Orderitem, type: :model do
 before :each do
    @good_orderitem = Orderitem.create(quantity: 10, product_id: 1, order_id: 1)
    @bad_orderitem = Orderitem.create(quantity: nil, product_id: nil, order_id: nil)
    @negative_nums = Orderitem.create(quantity: -10, product_id: 1, order_id: 1)
  end

  describe "validations" do 
    it "has a user id" do 
      expect(@good_orderitem).to be_valid
      expect(@bad_orderitem).to_not be_valid
    end

    it "has a quantity" do
      expect(@good_orderitem).to be_valid
      expect(@bad_orderitem).to_not be_valid
      expect(@bad_orderitem.errors.keys).to include(:quantity)
    end

    it "has a product_id" do
      expect(@bad_orderitem.errors.keys).to include(:product_id)
    end

    it "has a order_id" do
      expect(@bad_orderitem.errors.keys).to include(:order_id)
    end

    it "quantity must be greater than 0" do
      expect(@negative_nums.errors.keys).to include(:quantity)
    end
  end
end

