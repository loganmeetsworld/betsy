FactoryGirl.define do

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
    stock 10
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
    quantity 4
    association :product
    association :order
  end

  factory :category do
    name 'Catprodlol'
  end

end
