# require 'pry'
class Order < ActiveRecord::Base
  has_many :orderitems
  validates :credit_name, presence: true, on: :update, if: :awaiting_confirmation?
  validates :email,       presence: true, on: :update, if: :awaiting_confirmation?
  validates :credit_num,  presence: true, numericality: { only_integer: true }, length: { is: 16 }, on: :update, if: :awaiting_confirmation?
  validates :cvv,         presence: true, numericality: { only_integer: true }, length: { is: 3 },  on: :update, if: :awaiting_confirmation?
  validates :address,     presence: true, on: :update, if: :awaiting_confirmation?
  validates :city,        presence: true, on: :update, if: :awaiting_confirmation?
  validates :state,       presence: true, on: :update, if: :awaiting_confirmation?
  validates :zip,         presence: true, numericality: { only_integer: true }, length: { is: 5 },  on: :update, if: :awaiting_confirmation?

  serialize :dimensions

  def total_items
    total = 0
    self.orderitems.each do |item|
      total += item.quantity if !item.quantity.nil?
    end
    return total
  end

  def total_amount
    total = 0
    items = self.orderitems

    items.each do |item|
      total += item.product.price * item.quantity
    end
    return total
  end

  def awaiting_confirmation?
    status == "Awaiting confirmation"
  end

  def complete?
    complete = true
    a = []
    self.orderitems.each do |item|
      if item.shipped?
        a << true
      else
        a << false
      end
    end

    a.include?(false) ? complete = false : complete = true

    return complete
  end

  def self.orderitem_lookup(query)
    query = { packages: [{ dimensions: [25, 10, 15], weight: 500 }, { dimensions: [18, 30, 10], weight: 5000 }], origin: { state: "WA", city: "Seattle", zip: "98101" }, destination: { state: "IL", city: "Vernon Hills", zip: "60061" } }.to_json
    r = HTTParty.post("http://shipple.herokuapp.com/usps/", headers: { 'Content-Type' => 'application/json' }, body: params)
    parsed_orderitems = JSON.parse(orderitems)  
  end
end
