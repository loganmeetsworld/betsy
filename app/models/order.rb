class Order < ActiveRecord::Base
  has_many :orderitems
  validates :credit_name, presence: true, on: :update, if: :paid?
  validates :email,       presence: true, on: :update, if: :paid?
  validates :credit_num,  presence: true, on: :update, if: :paid?
  validates :cvv,         presence: true, on: :update, if: :paid?
  validates :address,     presence: true, on: :update, if: :paid?
  validates :city,        presence: true, on: :update, if: :paid?
  validates :state,       presence: true, on: :update, if: :paid?
  validates :zip,         presence: true, on: :update, if: :paid?

  def total_items
    total = 0
    self.orderitems.each do |item|
      total += item.quantity if !item.quantity.nil?
    end
    return total
  end

  def paid?
    status == "paid"
  end
end
