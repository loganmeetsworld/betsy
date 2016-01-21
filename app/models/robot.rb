class Robot < ActiveRecord::Base
  has_many :products
  has_many :orderitems, :through => :products

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :state, presence: true, length: { is: 2 }
  validates :country, presence: true, length: { is: 2 }
  validates :postal_code, presence: true, length: { is: 5 }
  validates :city, presence: true

  has_secure_password

  def revenue
    total = 0
    self.orderitems.each do |item|
      total += item.quantity * item.product.price if item.order.status == "paid"
    end
    return total
  end
end
