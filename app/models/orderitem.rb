class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :quantity_cannot_exceed_stock
  validates :order_id, presence: true
  validates :product_id, presence: true

<<<<<<< HEAD
=======
  def quantity_cannot_exceed_stock
    if quantity > Product.find(self.product_id).stock
      errors.add(:quantity, "can't exceed present stock")
    end
  end
  
>>>>>>> cart-view
end
