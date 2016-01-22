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

  def get_service(service)
    packages = []
    self.orderitems.each do |oi|
      packages << { dimensions: [oi.product.length, oi.product.height, oi.product.width], weight: oi.product.weight }
    end

    unless self.ship_city.empty? || self.ship_zip.empty? || self.ship_state.empty?
      destination = { state: self.ship_state, city: self.ship_city, zip: self.ship_zip }
    else
      destination = { state: self.state, city: self.city, zip: self.zip }
    end

    query = { packages: packages, origin: { state: "WA", city: "Seattle", zip: "98101" }, destination: destination }.to_json
    r = HTTParty.post("http://shipple.herokuapp.com/#{service}/", headers: { 'Content-Type' => 'application/json' }, body: query)
    unless r.nil? || r.empty?
      response = JSON.parse(r.body)
      return response["data"]
    else
      return nil
    end
  end

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
end
