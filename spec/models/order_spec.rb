require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  describe "total items calculation" do
    it "multiplies the item by quantity" do
      item = create(:orderitem, quantity: 3)
      create(:orderitem, quantity: 2, order_id: item.order.id, product_id: item.product.id)
      expect(item.order.total_items).to eq 5
    end
  end

  describe "total_amount" do
    it "calculates the total price" do
      order = create(:order)
      product = create(:product)
      other_product = create(:other_product)
      create(:orderitem, quantity: 3, order_id: order.id, product_id: product.id)
      create(:orderitem, quantity: 1, order_id: order.id, product_id: other_product.id)
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
      order = create(:order)
      create(:orderitem, order_id: order.id, shipped: true)
      create(:orderitem, order_id: order.id, shipped: true)
      expect(order.complete?).to eq true
    end

    it "returns false when all items are not shipped" do
      order = create(:order)
      create(:orderitem, order_id: order.id, shipped: false)
      create(:orderitem, order_id: order.id, shipped: true)
      expect(order.complete?).to eq false
    end
  end
end
