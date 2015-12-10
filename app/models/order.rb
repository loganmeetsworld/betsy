class Order < ActiveRecord::Base
  has_many :orderitems

  def total_items
    total = 0
    self.orderitems.each do |item|
      total += item.quantity if !item.quantity.nil?
    end
    return total
  end
end
