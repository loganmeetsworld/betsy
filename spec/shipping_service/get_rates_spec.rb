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

    # robot2 = Robot.create(username: "test2", email: "test2@test.com", password: "test", password_confirmation: "test", state: "WA", city: "Seattel", country: "US", postal_code: "12345")
    # product2 = Product.create(name: 'product', price: 10, stock: 10, length: 100, width: 100, height: 100, weight: 100, robot_id: robot2.id)
    # orderitem2 = Orderitem.create(product_id: product2.id)
    # order2 = Order.new(status: 'paid', email: 'test2@test.com', address: 'test', city: 'test', state: 'WA', zip: '98102', credit_name: 'test', credit_num: '1233456712345678', cvv: '123')
    # order2.orderitems.push(orderitem2)
    # bad_order = ShippingService::Order.new(order2)
    #
    # it "returns a string if the product is not within size guidelines" do
    #   expect(bad_order.get_total("ups")).to be_an_instance_of String
    # end
  end
end
