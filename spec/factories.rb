FactoryGirl.define do

  factory :robot do

  end

  factory :product do
    name 'product'
    price 10
    robot_id 1
    stock 1
    length 10
    width 10
    height 10
    weight 10
  end

end
