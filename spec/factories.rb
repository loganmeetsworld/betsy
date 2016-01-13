FactoryGirl.define do
  factory :product do
    name "Product"
    price 10
    robot_id 1
    stock 100
  end

  factory :order do
    status "pending"
  end

  factory :orderitem do
    quantity 1
    association :order
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
