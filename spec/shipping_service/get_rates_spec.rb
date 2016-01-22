require 'rails_helper'

RSpec.describe ShippingService::Order do
  let(:orderitem) { create(:orderitem) }
  let(:product) { orderitem.product }
  let(:order) { orderitem.order }
  let(:robot) { product.robot }
  let(:my_order) {ShippingService::Order.new(order)}

  describe "initialize(order)" do
    it "creates a new instance of ShippingService::Order" do
      expect(ShippingService::Order.new(order)).to be_an_instance_of ShippingService::Order
    end
  end

  describe "get_robot_location(robot)" do
    it "returns correctly formatted JSON" do
      json_response = {"country"=>"US", "state"=>"WA", "city"=>"Seattle", "postal_code"=>"98133"}
      expect(my_order.get_robot_location(robot)).to eq json_response
    end
  end

  describe "get_package_dimensions(product)" do
    it "returns correctly formatted JSON" do
      json_response = {"weight"=>10, "length"=>10, "width"=>10, "height"=>10, "cylinder"=>false}
      expect(my_order.get_package_dimensions(product)).to eq json_response
    end
  end

  describe "get_rates(origin, package, carrier)" do
    it "returns an array of shipping options and rates" do
      origin = my_order.get_robot_location(robot)
      package = my_order.get_package_dimensions(product)
      expect(my_order.get_rates(origin, package, "ups")).to be_an_instance_of Array
    end
  end

  describe "get_total(carrier)" do
    it "returns a hash if the product is within size guidelines" do
      expect(my_order.get_total("ups")).to be_an_instance_of Hash
    end

    it "returns a string if the product is not within size guidelines" do
      o = create(:order)
      prod = create(:product, width: 164, weight: 2000)
      item = Orderitem.create(quantity: 5, product_id: prod.id, order_id: o.id)
      new_order = ShippingService::Order.new(o)
      expect(new_order.get_total("ups")).to be_an_instance_of String
    end
  end
end
