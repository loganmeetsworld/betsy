require 'rails_helper'

RSpec.describe Robot, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_length_of(:state) }
    it { is_expected.to validate_length_of(:country) }
    it { is_expected.to validate_length_of(:postal_code) }
    it { is_expected.to have_secure_password }
  end

  describe "revenue method" do
    it "calculates the revenue" do
      @robot = Robot.create(username: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      @product = Product.create(name: 'test', price: 10, robot_id: @robot.id, stock: 1)
      @order = Order.create(status: "paid")
      @orderitem = Orderitem.create(product_id: @product.id, order_id: @order.id, quantity: 1)

      expect(@robot.revenue).to eq 10
    end
  end
end
