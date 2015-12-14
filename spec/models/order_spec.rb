require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
  end

  describe "total items calculation" do
    order = Order.create

    good_product = Product.create(name: 'product', price: 10, robot_id: 1, stock: 100)
    Orderitem.create(product_id: good_product.id, order_id: order.id, quantity: 3)
    Orderitem.create(product_id: good_product.id, order_id: order.id, quantity: 2)

    it "multiples the item by quantity" do
      expect(order.total_items).to eq 5
    end
  end

  describe "paid?" do
    it "checks an order has paid status" do
      paid = Order.new(status: "paid")
      pending = Order.new(status: "pending")
      expect(paid.paid?).to be true
      expect(pending.paid?).to be false
    end
  end
end
