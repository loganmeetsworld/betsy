require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:product) { create(:product) }
  let(:robot) { product.robot }

  describe "total items calculation" do
    it "multiples the item by quantity" do
      order = Order.create
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 3)
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 2)
      expect(order.total_items).to eq 5
    end
  end

  describe "total_amount" do
    it "calculates the total price" do
      order = Order.create
      other_product = Product.create(name: 'product2', price: 100, robot_id: robot.id, stock: 100, length: 10, width: 10, height: 10, weight: 10)
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 3)
      Orderitem.create(product_id: other_product.id, order_id: order.id, quantity: 1)
      expect(order.total_amount).to eq 130
    end
  end

  describe "awaiting_confirmation?" do
    it "checks an order has 'awaiting confirmation' status" do
      ac = Order.new(status: "Awaiting confirmation")
      pending = Order.new(status: "pending")
      expect(ac.awaiting_confirmation?).to be true
      expect(pending.awaiting_confirmation?).to be false
    end
  end

  describe "complete?" do
    it "returns true when all items are shipped" do
      order = Order.create
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 3, shipped: true)
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 1, shipped: true)
      expect(order.complete?).to eq true
    end

    it "returns false when all items are not shipped" do
      order = Order.create
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 3, shipped: false)
      Orderitem.create(product_id: product.id, order_id: order.id, quantity: 1, shipped: true)
      expect(order.complete?).to eq false
    end
  end
end
