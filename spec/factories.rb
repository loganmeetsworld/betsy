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

# status: "paid", email: "test@test.com", address: "test", city: "test", state: "WA", zip: "98102", credit_name: "test", credit_num: "4444444444444444", cvv: "444"
  factory :order do
    status 'paid'
    email 'test@test.com'
    address 'test'
    city 'test'
    state 'WA'
    zip '98102'
    credit_name 'test'
    credit_num '4444444444444444'
    cvv '444'
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
