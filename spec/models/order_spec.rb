require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do 
  end

  describe "total items calculation" do 
    order = Order.create

    Orderitem.create(product_id: 1, order_id: order.id, quantity: 3)
    Orderitem.create(product_id: 3, order_id: order.id, quantity: 2)

    it "multiples the item by quantity" do
      expect(order.total_items).to eq 5
    end
  end
end
