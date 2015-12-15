# require 'pry'
class Order < ActiveRecord::Base
  has_many :orderitems
  validates :credit_name, presence: true, on: :update, if: :paid?
  validates :email,       presence: true, on: :update, if: :paid?
  validates :credit_num,  presence: true, numericality: { only_integer: true }, length: { is: 16 }, on: :update, if: :paid?
  validates :cvv,         presence: true, numericality: { only_integer: true }, length: { is: 3 },  on: :update, if: :paid?
  validates :address,     presence: true, on: :update, if: :paid?
  validates :city,        presence: true, on: :update, if: :paid?
  validates :state,       presence: true, on: :update, if: :paid?
  validates :zip,         presence: true, numericality: { only_integer: true }, length: { is: 5 },  on: :update, if: :paid?

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
      total += item.product.price
    end
    return total
  end

  def paid?
    status == "paid"
  end

  # def revenue
  #   total = 0
  #   self.each do |item|
  #     if item.order.status == "paid"
  #       total += item.quantity * item.product.price
  #     end
  #   end
  #   # binding.pry
  #   return total
  # end
end
