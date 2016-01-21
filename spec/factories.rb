FactoryGirl.define do

  # @robot = Robot.create(username: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
  # @product = Product.create(name: 'test', price: 10, robot_id: @robot.id, stock: 1)
  # @order = Order.create(status: "paid")
  # @orderitem = Orderitem.create(product_id: @product.id, order_id: @order.id, quantity: 1)

  factory :robot do
    username 'test'
    email 'test@test.com'
    password 'test'
    password_confirmation 'test'
    state 'WA'
    country 'US'
    postal_code '98133'
  end

  factory :product do
    name 'product'
    price 10
    stock 1
    length 10
    width 10
    height 10
    weight 10
    association :robot
  end

  factory :order do
    status 'paid'
  end

  factory :orderitem do
    quantity 1
    association :product
    association :order
  end

end
