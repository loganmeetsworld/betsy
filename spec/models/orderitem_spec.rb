require 'rails_helper'

RSpec.describe Orderitem, type: :model do
  let(:orderitem) { create(:orderitem) }
  let(:product) { orderitem.product }

  describe "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:order_id) }
    it { is_expected.to validate_presence_of(:product_id) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0)}

    it "cannot exceed present stock" do
      expect(orderitem).to be_valid
      exceeds_stock = Orderitem.new(quantity: 500, product_id: product.id, order_id: orderitem.order.id)
      exceeds_stock.order.status = "pending"
      expect(exceeds_stock).to be_invalid
    end

  end
end
