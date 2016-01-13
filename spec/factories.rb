FactoryGirl.define do
  factory :product do
    name "Product"
    price 10
    robot_id 1
    stock 100
  end

  factory :other_product, class: Product do
    name "Product2"
    price 100
    robot_id 1
    stock 100
  end

  factory :order do
    status "pending"
  end

  factory :orderitem do
    quantity 1
    association :order, strategy: :build
    association :product
  end

  factory :category do
    name "art"
  end

  factory :robot do
    username 'test'
    email 'test@test.com'
    password 'test'
    password_confirmation 'test'
  end
end
